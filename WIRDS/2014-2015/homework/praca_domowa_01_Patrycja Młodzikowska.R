library(XLConnect)
library(dplyr)
library(ggplot2)

fName <- "C:/Users/Patrycja/Desktop/gospodarstwa.xls"
wb <- loadWorkbook(fName)
getSheets(wb)
gosp <- readWorksheet(wb, sheet = "gospodarstwa")


gosp$woj <- gsub(c("02", "04", "06", "08", "10", "12", "14", "16", "18", "20",
                              "22", "24", "26", "28", "30", "32"),
                   c("dolnoœl¹skie", "kujawsko-pomorskie", "lubelskie", "lubuskie", "³ódzkie",
                              "ma³opolskie", "mazowieckie", "opolskie", "podkarpackie", "podlaskie",
                              "pomorskie", "œl¹skie", "œwiêtokrzyskie", "warmiñsko-mazurskie",
                              "wielkopolskie", "zachodniopomorskie"), 
                 gosp$woj)

gosp %>%
  count(klm,woj) %>%
  group_by(woj) %>%
  mutate(procent = n/sum(n)) %>%
  ggplot(data = ., aes(x = " ", y = procent, group = klm, fill = klm)) +
  xlab("województwa ") +
  geom_bar(stat = 'identity', col='black') +
  facet_wrap(~woj, ncol=1) + 
  coord_flip()