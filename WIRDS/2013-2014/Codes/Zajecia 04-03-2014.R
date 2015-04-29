### wczytanie danych
load('Course Materials/WIRDS/DataSets/DiagnozaGosp.RData')

### wykorzystanie funkcji table do podsumowan jednowymiarowych
table(gosp$WOJEWODZTWO,useNA='ifany')
table(gosp$KLASA_MIEJSCOWOSCI,useNA='ifany')

#### tworzenie factora poleceniem factor
gosp$KM<-factor(
  gosp$KLASA_MIEJSCOWOSCI, # zmienna wejsciowa
  levels=1:6, ## wartosci zmiennej wejsciowej 
  labels=c('500tys. i więcej', ## etykiety zmiennych
           '200-500tys.',
           '100-200tys.',
           '20-100tys.',
           'pon. 20tys.',
           'wieś'))

### tworzenie tabeli dla zmiennej typu factor
table(gosp$KM)

#### przyklad problemu z factorami 
### tworzymy wektor numeryczny
test<-c(-8,-7,1,3)

### tworzymy faktor
tf<-factor(test,
      labels=c('a','b','c','d'),
      levels=test)

### chcac wrocic do wartosci orygninalnych otrzymujemy problem
### zamiast prawidzwych wartosci otrzymujemy wektor rozpoczynajacy sie
### od 1 do N
as.numeric(tf)

#### wynik tabeli mozna zapisac do obiektu
tab<-table(gosp$WOJEWODZTWO,gosp$KM)
### podgladamy strukture zbioru danych
str(tab)
### sprawdzamy atrybuty obiektu (ktore mozemy zmieniac)
attributes(tab)

#### 
# af1_1 - czy stać na chleb
# 1 - tak
# 2 - nie
### funkcja to tworzenia tabel krzyzowych
xtabs(~KM+af1_1,data=gosp)
### zapisujemy do obiektu
t1<-xtabs(~KM+af1_1+WOJEWODZTWO,data=gosp)
### zapisujemy obiekt jako data.frame
t1.df<-as.data.frame(t1)
### sprawdzamy jak wyglada ten obiekt
head(t1.df)

###### wykorzystamy funkcje xtabs do stworzenia tabeli krzyzowej
t2<-xtabs(~KM+af1_1,data=gosp)
### ustawienia procentow
prop.table(t2,margin=2)
### rozklady - suma obserwacji
margin.table(t2)
### rozklad brzegowy (1=wierszy, 2=kolumn)
margin.table(t2,margin=1)
### dodajemy marginesy
addmargins(t2)
### test chikwadrat (jako wynik dzialania summary)
summary(t2)

#### statystyki opisowe 
summary(gosp$gdoch_m_osoba)
### rozklad zmiennej dochod
hist(gosp$gdoch_m_osoba)
### rozklad zlogarytmowanej zmiennej gospodastw domowych
hist(log(gosp$gdoch_m_osoba))

### wykorzystanie funkcji aggregate do podsumowan
aggregate(gdoch_m_osoba~KM,data=gosp,
          FUN=median)
aggregate(gdoch_m_osoba~KM,data=gosp,
          FUN=mean)

### agregowanie wykorzystujace dwie zmienne
tab3<-aggregate(gdoch_m_osoba~KM+WOJEWODZTWO, data=gosp,FUN=median)

### zastosowanie funkcji xtabs do tworzenia tabeli krzyzowej na podstawie funkcji aggregate
xtabs(gdoch_m_osoba~WOJEWODZTWO+KM,
      data=tab3)

### wykorzystanie pakietu reshape2
library(reshape2)

### wybieramy podzbior funkcja subset
gospPodZb<-subset(gosp,
       select=c('gdoch_m_osoba',
              'WOJEWODZTWO','KM','WAGA_GD_2013'))

### wybieramy podzbior odwolujac sie przez  [
gospPodZb<-gospPodZb[!is.na(gospPodZb$WAGA_GD_2013),]

### wynik funkcji dcast
wynik<-dcast(gospPodZb, ## zbior wejsciowy
             value.var='gdoch_m_osoba', ### zmienna ktora analizujemy
             na.rm=T, ### usuniecie brakow danych
            WOJEWODZTWO~KM, ### przekoje 
            median, ### liczymy mediane
            fill=0) ## ustawiamy w miejscu brakow 0

wynik

