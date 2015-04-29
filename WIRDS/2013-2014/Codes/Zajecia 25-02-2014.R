
### tworzymy wektor
a<-1

class(etykiety) ### sprawdzamy klasę obiektu
etykiety$a ## sprawdzamy czy istnieje zmienna a w obiekcie etykiety
names(etykiety) ## sprawdzamy nazwy kolumn w zbiorze etykiety
dm<-dim(etykiety) ## zapisujemy wynikid zbioru danych
 
##### pierwsza tabela ###
## funkcje do tworzenia tabel
# table, xtabs, ftable, aggregate, dcast (reshape2)
## funcje dodatkowe
# prop.table

### raport tabelaryczny
table(gosp$WOJEWODZTWO)

### wykorzystanie funkcji table
tab<-table(gosp$WOJEWODZTWO,useNA='ifany')

### wykorzystanie funkcji prop.table i podanie wartości w procentach
round(prop.table(tab)*100,2)

### wykorzystanie funkcji format
formatC(prop.table(tab)*100,digits=2,format='f')

## lub pakiet scales
## install.packages('scales')
library(scales)
percent(as.numeric(prop.table(tab)))

### stworzenie wykresu tabelarycznego
barplot(tab)



















