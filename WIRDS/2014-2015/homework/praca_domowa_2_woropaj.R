data <- data.frame(Kategoria = c("własności budynku",
                                 "własności mieszkania",
                                 "spółdzielczego własnościowego prawa do lokalu",
                                 "spółdzielczego lokatorskiego prawa do lokalu",
                                 "najmu",
                                 "podnajmu",
                                 "pokrewieństwa",
                                 "innego prawa",
                                 "nieustalone"), 
                   r2002 = c(32.1,
                             10.4,
                             16.3,
                             7.9,
                             17.1,
                             1.3,
                             14.2,
                             0.7,
                             0), 
                   r2011 = c(37.8,
                             17.6,
                             13.5,
                             2.6,
                             16.6,
                             0.3,
                             9.5,
                             0.5,
                             1.8),
                   stringsAsFactors = FALSE)

library(ggplot2)
library(dplyr)
library(tidyr)

data_line <- data %>% gather(rok, y, r2002, r2011)


ggplot(data = data_line,
       aes(x = rok,
           y = y,
           colour = Kategoria,
           group = Kategoria,
           label = Kategoria)) +
  geom_point(size = 5) +
  geom_line() +
  xlab("Rok spisu") +
  ylab("Udział w %") +
  ggtitle("Udział ...") +
  geom_text(vjust = -1.35, hjust = 0.85, size = 4) +
  geom_text(aes(y = y, label = y), vjust = -1.35, hjust = -0.85, size = 4)