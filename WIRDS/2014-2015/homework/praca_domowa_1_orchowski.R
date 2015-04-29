### wczytanie danych z gospodarstw

library(XLConnect)
wb <- loadWorkbook('WIRDS/datasets/gospodarstwa.xls')
gosp <- readWorksheet(wb,'gospodarstwa')

library(dplyr)
gosp <- tbl_df(gosp)

library(ggplot2)

#zamiana zmiennej klm na etykiety

gosp <- gosp %>%
  mutate(klm = factor( x = klm,
                       levels = 6:1,
                       labels = c('Wie?', ## problem z kodowaniem znaków
                                  '<20',
                                  '[20,100)',
                                  '[100,200)',
                                  '[200,500)',
                                  '>=500'),
                       ordered = T))

# zmiana nr wojew?dztwa na etykiety

gosp <- gosp %>%
  mutate(woj = factor( x = woj,
                       levels = c('02','04','06','08','10','12','14',
                                  '16','18','20','22','24','26','28',
                                  '30','32'),
                       labels = c('dolno?l?skie',
                                  'kujawsko-pomorskie',
                                  'lubelskie',
                                  'lubuskie',
                                  '??dzkie',
                                  'ma?opolskie',
                                  'mazowieckie',
                                  'opolskie',
                                  'podkarpackie',
                                  'podlaskie',
                                  'pomorskie',
                                  '?l?skie',
                                  '?wi?tokrzyskie',
                                  'warmi?sko-mazurskie',
                                  'wielkopolskie',
                                  'zachodniopomorskie')))

# rysowanie wykresu

wykres <- gosp %>%
  count(klm,woj) %>%
  group_by(woj) %>%
  mutate(procent = n/sum(n)) %>%
  ggplot(data = .,
         aes(x = "",
             y = procent,
             group = klm,
             fill = klm)) +
  geom_bar(stat = 'identity',
           col='black') +
  facet_wrap(~woj, ncol=1) + 
  coord_flip() +
  xlab("Wojew?dztwo") +
  ggtitle("Wykres")

print(wykres)
ggsave("./praca_domowa.png", width = 15, height = 25, dpi = 160)
