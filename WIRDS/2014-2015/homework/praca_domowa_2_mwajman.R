library(XLConnect)
library(dplyr)
library(tidyr)
library(ggplot2)


dane2 <- read.table(file = 'C:/Users/Magda/Desktop/sem 8/wizualizacje/dane.txt',
                    header = T,
                    sep = '\t',
                    dec = ',',
                    stringsAsFactors = F )

dane_liniowy <- dane2 %>% 
  gather(rok, y, r2002, r2011)


ggplot(data= dane_liniowy,
       aes(x=rok,
           y=y,
           colour = Kategoria,
           group = Kategoria)) +
  geom_point(size=4) +
  geom_line() +
  theme_bw() +
  xlab('Rok spisu') +
  ylab('Udzia³ (%)') +
  ggtitle('Udzia³ w³asnoœci nieruchomoœci w 2002 i 2011 roku') +
  geom_text(aes(label=Kategoria), hjust=0, vjust=1, size = 3) +
  geom_text(aes(label=y), hjust=2, vjust=1, size =3)
