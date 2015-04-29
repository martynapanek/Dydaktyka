library(dplyr)
library(ggplot2)
library(scales)

load("matury_kraj.RData")

matury <- tbl_df(matury)

matury$wyniki_matur[matury$matura_nazwa == 'geografia rozszerzona'] <- matury$wyniki_matur[matury$matura_nazwa == 'geografia rozszerzona'] / 1.2
  
matury <- matury %>%
  mutate(wyniki_proc = wyniki_matur / 50)

ggplot(matury, 
       aes(x = matura_nazwa, 
           y = wyniki_proc,
           fill = as.character(rok))) + 
  stat_summary(fun.y = 'mean', 
               geom = 'bar', 
               colour = 'black',
               position = position_dodge(),  
               aes(width = 0.8)) +
  scale_y_continuous(labels = percent) +
  labs(x = 'Przedmioty', 
       y = 'Œredni wynik matury', 
       title = 'Œrednie wyniki matur z poszczególnych przedmiotów w podziale na roczniki') + 
  theme_bw() +
  theme(plot.title = element_text(size = 20, 
                                  face = "bold"), 
        axis.text.x = element_text(angle = 20, 
                                 size = 10, 
                                 face = 'bold'),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        legend.title = element_blank(),
        strip.text.x = element_text(size = 13)
  )
