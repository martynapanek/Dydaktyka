
library(dplyr)
library(tidyr)
library(ggplot2)


#Ustawienie working Directory. 
#Należy podać lokalizację repozytorium Dydaktyka/WIRDS
setwd("E:/Pliki/Studia/Wizualizacje i raportowanie/Dydaktyka/WIRDS")

#wczytujemy workspace z danymi z matur
load("./datasets/matury_kraj.RData")

#Wykres
matury %>%
  select(matura_nazwa, dysleksja, wyniki_matur) %>%
  filter(dysleksja!='NA') %>%
  mutate(dysleksja= ifelse(dysleksja=='TRUE','Dyslektycy','Bez dysleksji'))%>%
  group_by(matura_nazwa, dysleksja) %>%
  summarize(srednia=mean(wyniki_matur, na.rm=T)/60*100,
            liczebnosc = n()) %>%
  ggplot(data=.,
         aes(x=matura_nazwa,
             y=srednia,
             fill=dysleksja,
             ymax = 100))+
  geom_bar(stat='identity',
           position='dodge',
           colour='black')+ 
  theme_bw()+
  ylab('Średni wynik (%)')+
  xlab('Przedmiot')+
  scale_fill_discrete(name='Uczniowie:')+
  ggtitle('średni wynik matur z poszczególnych przedmiotów uczniów z dysleksją i bez dysleksji')+
  scale_y_continuous(limits=c(0,100))+
  geom_text(aes(label = round(srednia, digits=2)), 
            position = position_dodge(width=0.90), vjust=-0.4, size=4.5) +
  geom_hline(aes(yintercept = 30))
  