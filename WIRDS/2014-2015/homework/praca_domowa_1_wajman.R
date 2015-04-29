library(XLConnect)
wb <- loadWorkbook("C:/Users/Magda/Downloads/gospodarstwa.xls")
gosp <- readWorksheet (wb, sheet = "gospodarstwa")
library (dplyr)
gosp <- tbl_df(gosp)
library (ggplot2)

gosp$woj <- factor(gosp$woj,
                   levels = c("02", "04", "06", "08", "10", "12", "14", "16", "18", "20",
                              "22", "24", "26", "28", "30", "32"),
                   labels = c("dolnośląskie", "kujawsko-pomorskie", "lubelskie", "lubuskie", "łódzkie",
                              "małopolskie", "mazowieckie", "opolskie", "podkarpackie", "podlaskie",
                              "pomorskie", "śląskie", "świętokrzyskie", "warmińsko-mazurskie",
                              "wielkopolskie", "zachodniopomorskie"))


gosp %>%
  count(klm,woj) %>%
  group_by(woj) %>%
  mutate(procent = n/sum(n)) %>%
  ggplot(data = ., 
         aes(x = " ", 
             y = procent, 
             group = klm, 
             fill = klm)) +
  ggtitle('Udział respondentów wg województw
          ') +
  xlab("Województwo") +
  ylab("Procent obserwacji") +
  geom_bar(stat = 'identity', 
           col='red') +
  facet_wrap(~woj, ncol=1) +
  coord_flip()
