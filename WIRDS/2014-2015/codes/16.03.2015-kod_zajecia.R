#### wczytuje pakiety
library(openxlsx)
library(dplyr)
library(tidyr)
library(ggplot2)


# wczytanie danych --------------------------------------------------------

dane <- readWorkbook(xlsxFile = 'WIRDS/datasets/nsp2011_mieszkania.xlsx',
                     sheet = 1)

dane2 <- read.table(file = 'WIRDS/datasets/nsp2011_mieszkania.txt',
                    header = T,
                    sep = '\t',
                    dec = ',',
                    stringsAsFactors = F)

sapply(dane,class)


# wykres rozrzutu ---------------------------------------------------------

plot(x = dane$r2002,
     y = dane$r2011)
abline(a = 0, b = 1, col='red')

### bez opisów
ggplot(data = dane,
       aes( x = r2002,
            y = r2011)) +
  geom_point(size = 10) + 
  geom_abline(a = 0, b = 1, colour = 'red', size = 3) +
  coord_equal(xlim = c(0,40), ylim = c(0,40))

### kolory określają kategorie
ggplot(data = dane,
       aes( x = r2002,
            y = r2011,
            colour = Kategoria)) +
  geom_point(size = 5) + 
  geom_abline(a = 0, b = 1, colour = 'red', size = 3) +
  coord_equal(xlim = c(0,40), ylim = c(0,40))

### teksty przy punktach
ggplot(data = dane,
       aes( x = r2002,
            y = r2011,
            label = Kategoria)) +
  geom_point(size = 10) + 
  geom_abline(a = 0, b = 1, colour = 'red', size = 3) +
  coord_equal(xlim = c(-1,40), ylim = c(-1,40)) + 
  geom_text(hjust=0, vjust=-2,size=4)


# wykres liniowy ------------------

dane_liniowy <- dane %>% gather(rok,y,-Kategoria)
dane_liniowy <- dane %>% gather(rok,y,r2002,r2011)

ggplot(data = dane_liniowy,
       aes( x = rok,
            y = y,
            colour = Kategoria,
            group = Kategoria)) +
  geom_point(size=5) +
  geom_line() +
  theme_bw() +
  xlab('Rok spisu') +
  ylab('Udział (%)') +
  ggtitle('Udział ...')


# wykres słupkowy --------

ggplot(data = dane_liniowy,
       aes( x = Kategoria,
            y = y,
            fill = rok)) +
  geom_bar(stat = 'identity',
           position = 'dodge',
           colour = 'black') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45,
                                   vjust = 1,
                                   hjust = 1,
                                   size = 15))












