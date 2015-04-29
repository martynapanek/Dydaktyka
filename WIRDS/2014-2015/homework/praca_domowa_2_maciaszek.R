library(ggplot2)
library(tidyr)
library(plyr)
library(dplyr)

mieszkania <- read.table('nsp2011_mieszkania.txt',
                    header = T,
                    sep = '\t',
                    dec = ',',
                    stringsAsFactors = F,
                    encoding = "UTF-8")

mieszkania_liniowy <- mieszkania %>% gather(rok,y,-Kategoria)

wykres <- ggplot(data = mieszkania_liniowy,
       aes(x = rok,
           y = y,
           colour = Kategoria,
           group = Kategoria)) +
  geom_point(size = 4) +
  geom_line(size = 1) +
  theme_bw() +
  xlab('Rok spisu') +
  ylab('Udział (%)') +
  ggtitle('Udział ludności według kategorii prawa do lokalu w zależności od roku spisu') +
  geom_text(aes(label = y),
            subset = .(rok %in% 'r2002'),
            size = 5,
            hjust = 0,
            vjust = -0.5) +
  geom_text(aes(label = y),
            subset = .(rok %in% 'r2011'),
            size = 5,
            hjust = 1,
            vjust = -0.5) +
  geom_text(aes(label = Kategoria),
            subset = .(rok %in% 'r2002'),
            size = 4,
            hjust = 1.05,
            vjust = 0.5) +
  geom_text(aes(label = Kategoria),
            subset = .(rok %in% 'r2011'),
            size = 4,
            hjust = 0,
            vjust = 0.5) +
  guides(colour=FALSE)

print(wykres)
