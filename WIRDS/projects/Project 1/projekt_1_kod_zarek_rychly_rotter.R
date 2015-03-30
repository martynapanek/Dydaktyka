rm(list = ls(all = TRUE))
setwd("C:/Users/pracownik/Desktop/PBE")
library(ggplot2)
library(dplyr)
library(scales)
load("C:/Users/pracownik/Desktop/PBE/matury_kraj.RData")
matury <- tbl_df(matury)

matury$wyniki_matur[matury$matura_nazwa == 'geografia rozszerzona'] <- matury$wyniki_matur[matury$matura_nazwa == 'geografia rozszerzona'] / 1.2

matury$matura_nazwa[matury$matura_nazwa == 'geografia podstawowa'] <- 'GEO PDST'
matury$matura_nazwa[matury$matura_nazwa == 'geografia rozszerzona'] <- 'GEO ROZ'
matury$matura_nazwa[matury$matura_nazwa == 'informatyka podstawowa'] <- 'INF PDST'
matury$matura_nazwa[matury$matura_nazwa == 'informatyka rozszerzona'] <- 'INF ROZ'
matury$matura_nazwa[matury$matura_nazwa == 'matematyka podstawowa'] <- 'MAT PDST'
matury$matura_nazwa[matury$matura_nazwa == 'matematyka rozszerzona'] <- 'MAT ROZ'

matury %>%
  tbl_df() %>%
  mutate(c('var'='x')) %>%
  mutate(wyniki_matur = wyniki_matur / 50) %>%
  filter(rok %in% c(2010, 2014)) %>%
  ggplot(., 
         aes(x=as.character(rok), y=wyniki_matur, colour=as.character(rok))) + 
  geom_boxplot() + 
  facet_grid(. ~ matura_nazwa) +
  scale_colour_brewer(palette="Set1") +
  labs(x="Rok", y="Wyniki matur [pkt]", title="Porównanie rozstêpów w wynikach matur 2010 i 2014") +
  scale_y_continuous(labels = percent) +
  theme(plot.title = element_text(size=20, face="bold"), 
        axis.text.x=element_text(angle=10, size=10, face="bold"),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        legend.title=element_blank(),
        strip.text.x = element_text(size = 13, face="bold")
        )


