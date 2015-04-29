library(XLConnect)
wb <- loadWorkbook("WIRDS/datasets/gospodarstwa.xls")
gosp <- readWorksheet(wb, sheet = "gospodarstwa")

cechy <- readWorksheet(wb, sheet = "opis wariantów cech")
woj <- cechy[8:23, 2:3]

gosp$woj <- factor(gosp$woj, levels = woj$Col2, labels = woj$Col3)

library(dplyr)
gosp <- tbl_df(gosp)

library(ggplot2)
gosp %>%
  count(klm, woj) %>%
  group_by(woj) %>%
  mutate(procent = n/sum(n)) %>%
  ggplot(data = .,
         aes(x = "",
             y = procent,
             group = klm,
             fill = klm)) +
  geom_bar(stat = "identity",
           col = "black") +
  facet_wrap(~ woj, ncol = 1) +
  coord_flip() +
  xlab("Województwa") +
  theme_bw() +
  ggtitle("tytuł")

