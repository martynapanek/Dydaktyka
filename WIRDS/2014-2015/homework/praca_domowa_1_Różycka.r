library(XLConnect)
wb <- loadWorkbook('WIRDS/datasets/gospodarstwa.xls')
gosp <- readWorksheet(wb,'gospodarstwa')
vars <- readWorksheet(wb,'opis cech')
vars_labels <- readWorksheet(wb,'opis wariantów cech') ## problem z kodowaniem znaków (przez niezapisanie w UTF-8)

library(dplyr)
gosp <- tbl_df(gosp) 

library(ggplot2)
#library(ggthemes)

gosp <- gosp %>%
  mutate(klm = factor( x = klm,
                       levels = 6:1,
                       labels = c('Wie?',
                                  '<20',
                                  '[20,100)',
                                  '[100,200)',
                                  '[200,500)',
                                  '>=500'),
                       ordered = T))

gosp <- gosp %>%
  mutate(woj = factor( x = woj,
                       levels = c('02','04','06','08',
                                  '10','12','14','16',
                                  '18','20','22','24',
                                  '26','28','30','32'),
                       labels = c('dolno?l?skie','kujawsko-pomorskie',
                                  'lubelskie','lubuskie',
                                  '??dzkie','ma?opolskie',
                                  'mazowieckie','opolskie',
                                  'podkarpackie','podlaskie',
                                  'pomorskie','?l?skie',
                                  '?wi?tokrzyskie','warmi?sko-mazurskie',
                                  'wielkopolskie','zachodniopomorskie'),
                       ordered = T))

gosp %>%
  count(klm,woj) %>%
  group_by(woj) %>%
  mutate(procent = n/sum(n)) %>%
  ggplot(data = .,
         aes(x = '',
             y = procent,
             group = klm,
             fill = klm)) +
  geom_bar(stat = 'identity',
           col='black') +
  facet_wrap(~woj, ncol=1) + 
  xlab('Wojew?dztwa') +
  ggtitle('Udzia? procentowy danych klas miejscowo?ci 
          w poszczeg?lnych wojew?dztwach') +
  coord_flip()

