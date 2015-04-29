library(XLConnect)
wb <- loadWorkbook('D:/Studia/IV rok/2 semestr/Wizualizacje/gospodarstwa.xls')
gosp <- readWorksheet(wb,'gospodarstwa')
vars <- readWorksheet(wb,'opis cech')
vars_labels <- readWorksheet(wb,'opis wariantów cech')
library(dplyr)
library(ggplot2)

gosp<- gosp %>%
  mutate(klm=factor(x=klm,      # factor- przypisujemy etykiety
                     levels = 6:1,
                     labels=c('Wieœ', 
                              '<20', 
                              '[20,100)',
                              '[100,200)',
                              '[200,500)',
                              '>=500'),
                     ordered =T),
          woj=factor(x=woj,      # factor- przypisujemy etykiety
                    levels = c("02", "04", "06", "08", "10", "12", "14", "16", "18", "20",
                               "22", "24", "26", "28", "30", "32"),
                    labels=c("dolnoœl¹skie", "kujawsko-pomorskie", "lubelskie", "lubuskie", "³ódzkie",
                             "ma³opolskie", "mazowieckie", "opolskie", "podkarpackie", "podlaskie",
                             "pomorskie", "œl¹skie", "œwiêtokrzyskie", "warmiñsko-mazurskie",
                             "wielkopolskie", "zachodniopomorskie"),
                    ordered =T))
      
gosp %>%
  count(klm,woj) %>%
  group_by(woj) %>%
  mutate(procent = n/sum(n)) %>%
  ggplot(data = ., aes(x = " ", 
                       y = procent, 
                       group = klm, 
                       fill = klm)) +
  xlab("Województwo") +
  geom_bar(stat = 'identity', 
           col='black') +
  facet_wrap(~woj, ncol=1) + 
  coord_flip()