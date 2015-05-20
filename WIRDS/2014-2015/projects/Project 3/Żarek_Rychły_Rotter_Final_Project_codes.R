rm(list = ls(all = TRUE))
setwd("C:/Users/Super Kamil 3000/Desktop/R_workspace/WIRDS/")
library(ggplot2)
library(dplyr)
library(plyr)
library(stargazer)
library(corrplot)
library(gridBase)
library(gridExtra)
load("C:/Users/Super Kamil 3000/Desktop/R_workspace/WIRDS/matury_kraj.RData")
matury <- tbl_df(matury)
matury$wyniki_matur[matury$matura_nazwa == 'geografia rozszerzona'] <- matury$wyniki_matur[matury$matura_nazwa == 'geografia rozszerzona'] / 1.2
matury$rok <- as.character(matury$rok)

matury$matura_nazwa[matury$matura_nazwa == 'geografia podstawowa'] <- 'GEO PDST'
matury$matura_nazwa[matury$matura_nazwa == 'geografia rozszerzona'] <- 'GEO ROZ'
matury$matura_nazwa[matury$matura_nazwa == 'informatyka podstawowa'] <- 'INF PDST'
matury$matura_nazwa[matury$matura_nazwa == 'informatyka rozszerzona'] <- 'INF ROZ'
matury$matura_nazwa[matury$matura_nazwa == 'matematyka podstawowa'] <- 'MAT PDST'
matury$matura_nazwa[matury$matura_nazwa == 'matematyka rozszerzona'] <- 'MAT ROZ'

matury$zdane <- (matury$wyniki_matur >= 15)

# miniaturka

matury %>%
  tbl_df() %>%
  mutate(c('var'='x')) %>%
  filter(rok %in% c(2010, 2014)) %>%
  ggplot(., 
         aes(x=as.character(rok), y=wyniki_matur, colour=as.character(rok))) + 
  geom_boxplot() + 
  stat_summary(fun.y=mean, colour="black", geom="point", shape=18, size=3, show_guide = FALSE) +
  facet_grid(. ~ matura_nazwa) +
  scale_colour_brewer(palette="Set1") +
  labs(x="Rok", y="Wyniki matur [pkt]", title="Porównanie rozk³¹dów w wynikach matur 2010 i 2014") +
  theme(plot.title = element_text(size=20, face="bold"), 
        axis.text.x=element_text(angle=10, size=10, face="bold"),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        legend.title=element_blank(),
        strip.text.x = element_text(size = 13, face="bold")
  )

##### miniaturka cd.

means.barplot <- matury %>%
  tbl_df() %>%
  mutate(c('var'='x')) %>%
  filter(rok %in% c(2010, 2014)) %>%
  ggplot(., aes(x=as.character(rok), y=wyniki_matur,  fill = as.character(rok))) + 
  stat_summary(fun.y="mean", geom="bar", position=position_dodge(),  aes(width=0.8)) +
  facet_grid(. ~ matura_nazwa) +
  scale_colour_brewer(palette="Set1") +
  labs(x="Rok", y="Wyniki matur [pkt]", title="Porównanie œrednich i odchyleñ standardowych w wynikach") +
  theme(plot.title = element_text(size=20, face="bold"), 
        axis.text.x=element_text(angle=10, size=10, face="bold"),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        legend.title=element_blank(),
        strip.text.x = element_text(size = 13, face="bold")
  )


means.sem <- ddply(matury, c("rok", "matura_nazwa"), summarise, 
                   mean=mean(wyniki_matur), sem=sd(wyniki_matur))
means.sem <- transform(means.sem, lower=mean-sem, upper=mean+sem)
colnames(means.sem)[3] <- "wyniki_matur"
means.sem <- filter(means.sem, rok %in% c(2010, 2014))

means.barplot + 
  geom_errorbar(aes(ymax=upper, ymin=lower),
                position=position_dodge(0.9),
                data=means.sem) +
  ylim(0,50)

# corrplot

df <- matury %>%
  filter(matura_nazwa == 'MAT PDST') %>%
  select(wyniki_matur, plec, dysleksja, laureat, publiczna, dla_doroslych, specjalna, przyszpitalna, rodzaj_gminy, matura_miedzynarodowa, wielkosc_miejscowosci)

df$plec[df$plec == "k"] <- FALSE
df$plec[df$plec == "m"] <- TRUE
df$plec <- as.logical(df$plec)
df$rodzaj_gminy[df$rodzaj_gminy == "miejsko-wiejska"] <- FALSE
df$rodzaj_gminy[df$rodzaj_gminy == "wiejska"] <- FALSE
df$rodzaj_gminy[df$rodzaj_gminy == "dzielnica m.st. Warszawy"] <- TRUE
df$rodzaj_gminy[df$rodzaj_gminy == "miejska"] <- TRUE
df$rodzaj_gminy <- as.logical(df$rodzaj_gminy)
df$plec <- as.numeric(df$plec)
colnames(df)[9:11] <- c("gmina_miejska", "mat_miedzyn", "wielk_miesc")
colnames(df)[2] <- c("mezczyzna")


M <- cor(df, use = "complete")

corrplot(M, method = "circle",
         tl.col = "black",
         diag= FALSE, 
         col = colorRampPalette(c("red","blue","green"))(100))

# tabela z modelami - mat pdst

df <- matury %>%
  filter(matura_nazwa == 'MAT PDST') %>%
  select(wyniki_matur, plec, dysleksja, laureat, publiczna, dla_doroslych, specjalna, przyszpitalna, rodzaj_gminy, matura_miedzynarodowa, wielkosc_miejscowosci)

df$plec[df$plec == "k"] <- FALSE
df$plec[df$plec == "m"] <- TRUE
df$plec <- as.logical(df$plec)
df$rodzaj_gminy[df$rodzaj_gminy == "miejsko-wiejska"] <- FALSE
df$rodzaj_gminy[df$rodzaj_gminy == "wiejska"] <- FALSE
df$rodzaj_gminy[df$rodzaj_gminy == "dzielnica m.st. Warszawy"] <- TRUE
df$rodzaj_gminy[df$rodzaj_gminy == "miejska"] <- TRUE
df$rodzaj_gminy <- as.logical(df$rodzaj_gminy)
df$plec <- as.numeric(df$plec)
colnames(df)[9] <- c("gmina_miejska")
colnames(df)[2] <- c("mezczyzna")

linear.1 <- lm(df$wyniki_matur ~ df$mezczyzna + df$dysleksja + df$laureat + df$publiczna + df$dla_doroslych +
               df$specjalna + df$przyszpitalna + df$gmina_miejska  + df$matura_miedzynarodowa + df$wielkosc_miejscowosci, na.action=na.omit)
linear.2 <- lm(df$wyniki_matur ~ df$publiczna + df$dysleksja + df$laureat + df$specjalna + df$matura_miedzynarodowa + df$gmina_miejska, na.action=na.omit)
df$zdane <- (df$wyniki_matur >= 15)
df$zdane <- as.numeric(df$zdane)
probit.model <- glm(df$zdane ~ df$mezczyzna + df$dysleksja + df$laureat + df$publiczna + df$dla_doroslych +
                      df$specjalna + df$przyszpitalna + df$gmina_miejska  + df$matura_miedzynarodowa + df$wielkosc_miejscowosci, 
                    family = binomial(link = "probit"))

out2 <- stargazer(linear.1, linear.2, probit.model, title="Porównanie modeli ",type = "text")

#### Wykres liniowy

 pl1 <- matury %>%
  filter(matura_nazwa == 'MAT PDST') %>%
  group_by(rok) %>%
  summarise(m = mean(wyniki_matur)) %>%
  ggplot(., aes(x=as.numeric(rok), y=m)) +
  geom_line(colour = "blue", size = 2) +
  ylim(20,40) +
  theme_bw() +
  labs(y = "Wyniki matur [pkt]", x = "Rok", title="Wyniki egzaminu z matematyki podstawowej") +
  theme(plot.title = element_text(size=20, face="bold")) +
  geom_text(aes(label=round(m, digits = 2)), hjust=0.5, vjust=-1, size = 4.5)

 pl2 <- matury %>%
    filter(matura_nazwa == 'MAT PDST') %>%
    group_by(rok) %>%
    summarise(m = ((length(zdane))-sum(as.numeric(zdane)))/length(zdane)) %>%
  ggplot(., aes(x=as.numeric(rok), y=m)) +
  geom_line(colour = "red", size = 2) +
  ylim(0,0.5) +
  theme_bw() +
  labs(x = "Rok", y = "Udzia³ niezdanych matur") +
  theme(plot.title = element_text(size=20, face="bold")) +
  geom_text(aes(label=round(m, digits = 2)), hjust=0.5, vjust=-1, size = 4.5)


grid.arrange(pl1,pl2)

#### Barplot z województwami

df <- matury %>%
  filter(matura_nazwa == 'MAT PDST') %>%
  group_by(wojewodztwo) %>%
  summarise(m = ((length(zdane))-sum(as.numeric(zdane)))/length(zdane))
  df <- df[1:16,]

  ggplot(df, aes(x=wojewodztwo, y=m, fill = m)) +
  geom_bar(stat = "identity") +
  scale_fill_continuous(low="green", high="red", limits=c(0.18, 0.25)) +
  ylim(0,0.25) +
  labs(x="Województwo", y="Udzia³ niezdanych matur", title="Udzia³ niezdanych matur z matematyki podstawowej") + 
  theme(plot.title = element_text(size=20, face="bold"), 
        axis.text.x=element_text(angle=20, size=10, face="bold"),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        legend.title=element_blank(),
        strip.text.x = element_text(size = 13)
  )





