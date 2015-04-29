#Praca domowa z zaj?? 2.03.2015

library(XLConnect)

wb <- loadWorkbook('gospodarstwa.xls')
gosp <- readWorksheet(wb,'gospodarstwa')
vars <- readWorksheet(wb,'opis cech')
vars_labels <- readWorksheet(wb,'opis wariantów cech')

library(dplyr)

gosp <- gosp %>%
  mutate(klm = factor( x = klm,
                       levels = 6:1,
                       labels = c('Wie??',
                                  '<20',
                                  '[20,100)',
                                  '[100,200)',
                                  '[200,500)',
                                  '>=500'),
                       ordered = T)) %>%
  mutate(woj = factor(x = woj,
                      labels = c('Dolno?l?skie',
                                 'Kujawsko-pomorskie',
                                 'Lubelskie',
                                 'Lubuskie',
                                 '??dzkie',
                                 'Ma?opolskie',
                                 'Mazowieckie',
                                 'Opolskie',
                                 'Podkarpackie',
                                 'Podlaskie',
                                 'Pomorskie',
                                 '?l?skie',
                                 '?wi?tokrzyskie',
                                 'Warmi?sko-mazurskie',
                                 'Wielkopolskie',
                                 'Zachodniopomorskie'),
                      ordered = T))

library(ggplot2)

wykres <- gosp %>%
  count(klm,woj) %>%
  group_by(woj) %>%
  mutate(procent = n/sum(n)) %>%
  ggplot(data = .,
         aes(x = klm,
             y = procent,
             fill = klm)) +
  geom_bar(stat = 'identity',
           col='black') +
  facet_wrap(~woj) +
  coord_flip() 


library(ggthemes)

wykres + 
  ggtitle('Udzia? respondent?w wed?ug klasy wielko?ci miejscowo?ci w poszczeg?lnych wojew?dztwach') +
  xlab('Klasa wielko?ci miejscowo?ci') + 
  ylab('Procent obserwacji') +
  guides(fill=FALSE) +
  theme_hc()
