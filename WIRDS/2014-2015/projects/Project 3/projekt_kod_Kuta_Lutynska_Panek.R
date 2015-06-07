library(XLConnect)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
library(sjPlot)
library(ggthemes)


###########################Pobranie zbioru danych############################
load('D:/UEP/Studia/IV rok/2 semestr/Wizualizacje/matury_kraj.RData')

######Wykres 1 - œredni procentowy wynik matur z matematyki podstawowej######
##############dla poszczególnych województw w latach 2011-2014###############

#Wykres 1 - Tworzenie nowego zbioru 
wynik <- matury %>%
  select(wyniki_matur)%>%
  group_by(rok=matury$rok, woj=matury$wojewodztwo)%>%
  filter(rok %in% c(2011, 2012, 2013, 2014))%>%
  summarise(procent=if(matury$matura_nazwa=='matematyka podstawowa'){
    N=mean(wyniki_matur/50*100)}
    else{N=mean(wyniki_matur*2)})

#Wykres 1 - Nadanie etykiet 
wynik$woj <- factor(wynik$woj,
                    levels = c('dolnoœl¹skie', 'podlaskie', 'wielkopolskie'),
                    labels = c('Dolnoœl¹skie',
                               'Podlaskie',
                               'Wielkopolskie'))
#Wykres 1 - Stworzenie wykresu
ggplot(data=wynik,
       aes(x=rok,
           y=procent,
           colour=woj,
           group=woj))+
  geom_point(size=5)+
  geom_line(size=2)+
  theme_gray()+
  scale_colour_tableau(name='Województwo')+
  xlab('Rok')+
  ylab('Procentowe wyniki matur')+
  ggtitle('Œredni procentowy wyniki matur z matematyki podstawowej 
          \n dla poszczególnych województw w latach 2011 - 2014 \n')+
  theme(plot.title=(element_text(face='bold', size = 15)))

###################Tabela 1 - Statystyki opisowe wzglêdem okrêgów############

#Tabela 1 - Tworzenie nowego zbioru danych dla oke
dane_oke<- matury%>%
  select(wyniki_matur)%>%
  group_by(oke=matury$oke, 
           rok=matury$rok, 
           matura_nazwa=matury$matura_nazwa)%>%
  filter(rok == 2014)%>%
  filter(matura_nazwa=="matematyka rozszerzona")%>%
  filter(oke=="£om¿a" | oke =="Poznañ" | oke=="Wroc³aw") %>%
  summarise(N=n(),
            Œrednia = round(mean(wyniki_matur)*2,2), 
            odchylenie_standardowe = round(sd(wyniki_matur)*2,2),
            Mediana = round(median(wyniki_matur)*2,2))

#Tabela 1 - Zmiana nazwy kolumn dla oke
names(dane_oke)[1]<-"OKE"
names(dane_oke)[2]<-"Rok"
names(dane_oke)[3]<-"Matura"
names(dane_oke)[6]<-"Odchydlenie standardowe"

#Tabela 1 - Stworzenie tabeli dla oke
sjt.df(stringVariable = "",dane_oke, 
       describe=FALSE, 
       encoding='cp1250',
       title = 'Statystyki opisowe wzglêdem 
                Okrêowych Komisji Egzaminacyjnych')

############Tabela 2 - Statystyki opisowe wzglêdem wojwództw#################

#Tabela 2 - Tworzenie nowego zbioru danych dla województw
dane_woj<- matury%>%
  select(wyniki_matur)%>%
  group_by(wojewodztwo=matury$wojewodztwo, 
           rok=matury$rok, 
           matura_nazwa=matury$matura_nazwa)%>%
  filter(rok == 2014)%>%
  filter(matura_nazwa=="matematyka rozszerzona")%>%
  filter(wojewodztwo == 'podlaskie' | 
          wojewodztwo =='wielkopolskie' | 
          wojewodztwo =='dolnoœl¹skie') %>%
  summarise(N=n(),
            Œrednia = round(mean(wyniki_matur)*2,2), 
            odchylenie_standardowe = round(sd(wyniki_matur)*2,2),
            Mediana = round(median(wyniki_matur)*2,2))

#Tabela 2 - Zmiana nazwy kolumn dla województw
names(dane_woj)[1]<-"Województwo"
names(dane_woj)[2]<-"Rok"
names(dane_woj)[3]<-"Matura"
names(dane_woj)[6]<-"Odchydlenie standardowe"

#Tabela 2 - Stworzenie tabeli dla województw
sjt.df(stringVariable = "",dane_woj, 
       describe=FALSE, 
       encoding='cp1250',
       title = 'Statystyki opisowe wzglêdem województw')

##############Tabela 3 - Tabela korelacji informatka/matematyka###########

#Tabela 3 - Stworzenie nowego zbioru danych dla informatyki
infa <-matury%>%
  select(id_obserwacji,rok, matura_nazwa,wyniki_matur,pop_podejscie)%>%
  filter(rok==2014)%>%
  filter(matura_nazwa=="informatyka podstawowa")%>%
  filter(pop_podejscie %in% NA)

#Tabela 3 - Stworzenie nowego zbioru danych dla matematyki
matma<-matury%>%
  select(id_obserwacji,rok, matura_nazwa,wyniki_matur)%>%
  filter(rok==2014)%>%
  filter(matura_nazwa=="matematyka podstawowa")

#Tabela 3 - Po³¹czenie zbiorów infa i matma wzglêdem id_obserwacji

suma <- merge(infa,matma,by="id_obserwacji")

#Tabela 3 - Stworzenie nowego zbioru danych z wynikami 
#informatyki i matematyki

dane<- data.frame(suma$wyniki_matur.x, suma$wyniki_matur.y)

#Tabela 3 - Nadanie nazw kolumnom w zbiorze dane
names(dane)[1]<- "informatyka"
names(dane)[2]<- "matematyka"

#Tabela 3 - Stworzenie tabeli korelacji informatyka/matematyka
sjt.corr(dane,
         corMethod='pearson',
         missingDeletion='pairwise',
         title='Macierz wspó³czynników korelacji Pearsona',
         encoding='cp1250',
         val.rm=0.3,
         showPValues=TRUE,
         pvaluesAsNumbers=TRUE,
         CSS=list(css.valueremove="color: #FF4040")
)


######Wykres 2 - Udzia³ procentowy wybranych przedmiotów spoœród przedmiotów dodatkowych######
##############w podziale na ró¿ne typy szkó³ w 2014 roku###############

#Wykres 2-nadanie etykiet
fac <- matury %>%
  mutate(typ_szkoly=factor (x=typ_szkoly,
                            levels= c('LO', 'LOU', 'LP', 'T', 'TU'),
                            labels=c('Liceum Ogólnokszta³c¹ce',
                                     'Liceum uzupe³niaj¹ce',
                                     'Liceum plastyczne',
                                     'Technikum',
                                     'Technikum uzupe³niaj¹ce'),
                            exclude = NULL,
                            ordered=T))

#wykres 2- Stworzenie wykresu
fac %>%
  filter (rok==2014)%>%
  filter(matura_nazwa!="matematyka podstawowa")%>%
  count(typ_szkoly, matura_nazwa) %>%
  group_by(typ_szkoly) %>%
  mutate(procent = n/sum(n)) %>%
  ggplot(data =.,
         aes( x = typ_szkoly,
              y = procent,
              group = matura_nazwa,
              fill = matura_nazwa))+
  xlab("Rodzaj szko³y")+
  ylab("Procent zdawanych mtur")+
  geom_bar(stat='identity',
           col = 'black')+
  theme(axis.text.x=element_text(angle=45, vjust=1, hjust=1, size=12))+
  scale_fill_discrete(name="Nazwa matury:")+
  ggtitle("Udzia³ procentowy wybranych przedmiotów 
          \n spoœród przedmiotów dodatkowych 
          \n w podziale na ró¿ne typy szkó³ w 2014 roku")


######Wykres 3 - Œredni wynik matur z informatyki i matematyki######
############## w 3 okrêgach: OKE £om¿a, OKE Poznañ i OKE Wroc³aw###############
matury %>%
  select(matura_nazwa, oke, wyniki_matur,rok) %>%
  filter (rok==2014)%>%
  filter(matura_nazwa!="geografia podstawowa" & 
           matura_nazwa!="geografia rozszerzona")%>%
  filter(oke=="£om¿a" | 
        oke=="Poznañ" | 
        oke=="Wroc³aw")%>%
  group_by(matura_nazwa, oke)%>%
  summarize(srednia=mean(wyniki_matur, na.rm=T)/50*100) %>%
  ggplot(data=.,
         aes(x=matura_nazwa,
             y=srednia,
             fill=oke,
             ymax = 60))+
  geom_bar(stat='identity',
           position='dodge',
           colour='black')+ 
  theme_bw()+
  ylab('Œredni wynik (%)')+
  xlab('Przedmiot')+
  scale_fill_discrete(name='Okrêg:')+
  ggtitle('Œredni wynik matur z informatyki i matematyki \n 
          w 3 okrêgach: OKE £om¿a, OKE Poznañ i OKE Wroc³aw')+
  geom_text(aes(label=round(srednia, digits=1)), 
            vjust=-0.5, position=position_dodge(.8), size=4)+
  geom_hline(aes(yintercept = 30))

##############Tabela 4 - Tabela wynikowa modelu liniowego ###########
###zmienna zale¿na-wynik z informatyki podstawowej

###Tabela 4- Ustalenie zbioru###

#Tabela 4- Stworzenie nowego zbioru dla informatyki
inf <-matury%>%
  filter(rok==2014)%>%
  filter(matura_nazwa=="informatyka podstawowa")

#Tabela 4- Stworzenie nowego zbioru dla matematyki
mat<-matury%>%
  select(id_obserwacji,rok, matura_nazwa,wyniki_matur)%>%
  filter(rok==2014)%>%
  filter(matura_nazwa=="matematyka podstawowa")

#Tabela 4- Stworzenie nowego zbioru ³¹cznego dla województw:dolnoœl¹skiego, podlaskiego i wielkopolskiego
total <- merge(inf,mat,by="id_obserwacji")%>%
  filter(wojewodztwo=="dolnoœl¹skie" | wojewodztwo=="podlaskie" | wojewodztwo=="wielkopolskie")

#Tabela 4-nadanie nowych nazw dla kolumn
names(total)[28]<- "wynik_informatyka"
names(total)[31]<- "wynik_matematyka"


#Tabela 4-sprawdzenie, jakie zmienne niezale¿ne istniej¹ w zbiorze i wybór zmiennych do modleu
total%>% count(typ_szkoly) #zmienne niezale¿ne: technikum i liceum
total%>% count(dysleksja) #zmienne niezale¿ne: dysleksjaTRUE i dysleksjaFALSE
total%>%count(plec) #zmienne niezalezne: plecm i pleck
total%>%count(laureat) #brak laureatów, nie dodajemy zmiennej do modelu
total%>%count(matura_miedzynarodowa)#zmienne niezale¿ne:matura_miedzynarodowaTRUE i matura_miedzynarodowaFALSE
total%>%count(pop_podejscie)#wszyscy maja pierwsze podejscie, nie dodajemy tej zmiennej do modelu

#Tabela 4-Koñcowa lista zmiennych wprowadzonych do modelu:
#Zmienne: wynik matury z matematyki,typ szko³y, p³eæ, dysleksja,matura miedzynarodowa

#Tabela 4-Stworzenie modelu
model <-lm(wynik_informatyka~wynik_matematyka+plec+dysleksja+typ_szkoly+matura_miedzynarodowa+wojewodztwo, data=total)
summary(model)
sjt.lm(model,
       stringB = "Beta",
       boldpvalues = TRUE,
       stringCI = "przedzia³ ufnoœci",
       showHeaderStrings = FALSE,
       stringModel = "Model liniowy zale¿noœci wyniku matury z informatyki od wybranych czynników",
       stringObservations ='Iloœæ obserwacji',
       encoding= 'cp1250',
       stringIntercept= 'Wyraz wolny',
       showStdBeta=TRUE)