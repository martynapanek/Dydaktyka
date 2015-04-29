load("matury_kraj.RData")
library(dplyr)
library(ggplot2)
matury <- tbl_df(matury)

matury$typ_szkoly <- factor(matury$typ_szkoly, levels = c("LO", "LOU", "LP", "T", "TU"),
                            labels = c("Liceum Ogólnokształcące", "LO Uzupełniające", "Liceum Profilowane", "Technikum", "Technikum Uzupełniające"))

library(ggthemes)
# propozycja 3 ------------------------------------------------------------
matury %>%
  filter(ifelse(matura_nazwa == "geografia rozszerzona", wyniki_matur < 18, wyniki_matur < 15)) %>%
  count(typ_szkoly, rok) %>%
  group_by(rok) %>%
  mutate(procent = n / sum(n),
         csum = cumsum(procent) - procent/4) %>%
  ggplot(data = ., aes(x = rok,
                       y = procent,
                       fill = typ_szkoly,
                       group = typ_szkoly,
                       label = round(procent, 3)*100,
                       ymax = 1)) +
  geom_bar(stat = "identity", position = "fill") +
  ggtitle("Rokroczny procentowy udział niezaliczonych matur \nze względu na typ szkoły (w stosunku do ogółu)") +
  xlab("Rok pisania matury") +
  ylab("Procentowy udział niezaliczonych matur") +
  geom_text(aes(y = csum), vjust = 1, col = "white", size = 4, stat = "identity") +
  scale_fill_discrete(name = "Typ szkoły") +
  scale_y_continuous(labels = c("0", "25", "50", "75", "100")) +
  theme(plot.title = element_text(face = "bold")) +
  theme_hc()


