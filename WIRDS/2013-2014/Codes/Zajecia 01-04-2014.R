### wczytanie potrzebnych pakietów
library(ggplot2)
library(scales)
library(ggthemes)
library(reshape2)

### sprawdzamy klasę zmiennej klasa_miejscowosci
class(diagnozaGD2013$KLASA_MIEJSCOWOSCI)
### zmieniamy na factor
diagnozaGD2013$KLASA_MIEJSCOWOSCI<-as.factor(diagnozaGD2013$KLASA_MIEJSCOWOSCI)
### sprawdzamy klasę po zmianie
class(diagnozaGD2013$KLASA_MIEJSCOWOSCI)

### qplot - wykres pudelkowy 
qplot(x=KLASA_MIEJSCOWOSCI,
      y=gdoch_m_osoba_ekw,
      data=diagnozaGD2013,
      geom='boxplot')

### teraz stworzymy wykorzystujemy funkcje ggplot

ggplot(data=diagnozaGD2013,
       aes(x=KLASA_MIEJSCOWOSCI,
           y=gdoch_m_osoba_ekw)) +
  geom_boxplot() 

### dodajemy jeszcze punkty

ggplot(data=diagnozaGD2013,
       aes(x=KLASA_MIEJSCOWOSCI,
           y=gdoch_m_osoba_ekw)) +
  geom_boxplot() + geom_jitter()

### sprawdzamy jak bedzie wyglądał wykres jak
### miejscami zamienimy jitter i boxplot
ggplot(data=diagnozaGD2013,
       aes(x=KLASA_MIEJSCOWOSCI,
           y=gdoch_m_osoba_ekw)) +
  geom_jitter() +
  geom_boxplot()

### uzywamy argumentu fill aby zmienic kolory wypełnienia
ggplot(data=diagnozaGD2013,
       aes(x=KLASA_MIEJSCOWOSCI,
           y=gdoch_m_osoba_ekw,
           fill=KLASA_MIEJSCOWOSCI)) +
  geom_jitter() +
  geom_boxplot()

### używamy opcji colour (lub color) w celu ustawienia kolorów
ggplot(data=diagnozaGD2013,
       aes(x=KLASA_MIEJSCOWOSCI,
           y=gdoch_m_osoba_ekw,
           colour=KLASA_MIEJSCOWOSCI)) +
  geom_jitter() +
  geom_boxplot()

### uzywamy point zamiast jitter
ggplot(data=diagnozaGD2013,
       aes(x=KLASA_MIEJSCOWOSCI,
           y=gdoch_m_osoba_ekw,
           colour=KLASA_MIEJSCOWOSCI)) +
  geom_point() + 
  geom_boxplot()


#### ustawiamy kolory i ksztalty

ggplot(data=diagnozaGD2013,
       aes(x=gdoch_m_osoba_ekw,
           y=gdoch_r_osoba_ekw,
           color=as.factor(WOJEWODZTWO),
           shape=KLASA_MIEJSCOWOSCI)) +
  geom_point()

### sprawdzamy czy zadziala (i jak zadziala) bez okreslania factor
ggplot(data=diagnozaGD2013,
       aes(x=gdoch_m_osoba_ekw,
           y=gdoch_r_osoba_ekw,
           color=WOJEWODZTWO,
           shape=KLASA_MIEJSCOWOSCI)) +
  geom_point()

##### wynik możemy przypisać do obiektu

p<-ggplot(data=diagnozaGD2013,
          aes(x=gdoch_m_osoba_ekw,
              y=gdoch_r_osoba_ekw))

### tworzymy wykres rozrzutu, a nastepnie zawijamy 
p + geom_point() + 
  facet_wrap(KLASA_MIEJSCOWOSCI~WOJEWODZTWO)

### ustalamy macierzowy sposób przedstawienia dwóch zmiennych grupujacych 
p + geom_point() +
  facet_grid(KLASA_MIEJSCOWOSCI~WOJEWODZTWO)


#### agregujemy dane (UWAGA! formalnie dzialamy na danych nie przeważonych
### aby uzyskać poprawne oszacowania należałoby dane przeważyć!)

### zastosujemy do tego funkcje sapply
tab<-sapply(indywid2013[,10:25],table)
### sprawdzamy klase
class(tab)
### zamieniamy na data.frame
tab<-as.data.frame(tab)
### ID
tab$ID<-rownames(tab)
#### meltujemy zbior danych
tab.long<-melt(tab,id.vars='ID')

## wykres słupkowy 
p<-ggplot(data=tab.long,
       aes(x=variable,
           y=value,
           fill=ID)) +
  geom_bar(stat='identity')

### zmieniamy poszczególne elementy
p + coord_flip() +  ### zmieniamy uklad zmiennych
  xlab('') + ### usuwamy opis osi OX
  ylab('') + ### usuwamy opis osi OY
  scale_fill_brewer(palette='Blues', ### ustawiamy kolory na niebieskie
            name='Wariant \n odpowiedzi', ### nadajemy etykiety dla zmiennych
            breaks=1:6, ### wartości prawidziwe (w zbiorze danych)
            labels=c('B.zadowolony/a', ### etykiety jakie chcemy naniesc
                     'Zadowolony/a',
                     'D.zadowolony/a',
                     'D.niezadowolony/a',
                     'Niezadowolony/a',
                     'B.niezadowolony/a')) +
  geom_bar(stat='identity',color='black') + ### wskazujemy geometrie słupkową (bar)
  theme_bw() + ### usuwamy m.in. tlo
  ggtitle('Zadowolenie z dziedzin życia') ## tytuł wykresu


paste0('GP62_',sprintf('%02d',1:16))



































