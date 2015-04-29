###  wczytanie pakietow
library(RColorBrewer)
library(vioplot)

### polecenie setwd ustala domyślny folder
setwd("~/Dokumenty/Projekty/Projekty_R/UNIVERSITY/Course Materials/WIRDS/DataSets")

### polecenie load wczytuje pliki o rozszerzeniu RData
load('DiagnozaGosp.RData')

###
klm<-table(gosp$KLASA_MIEJSCOWOSCI)
pie(klm)

####
library(RColorBrewer)
brewer.pal(5,'Blues')
display.brewer.pal(7,'Blues')
display.brewer.all()
paleta<-brewer.pal(6,'Spectral')

pie(klm,col=paleta,
    labels=c('500+','200-500',
             '100-200','20-100',
             'pon.20','wieś'),
    main='Rozkład respondentów wg klasy miejscowosci',
    sub='Źródło: Opracowanie własne na podstawie badania Diagnoza Społeczna')


### wykresy słupkowe ###
barplot(klm)
klm2<-sort(klm,decreasing=T)
barplot(klm2,
        col=paleta[2],
        border='red',
        horiz=T,
        cex.axis=2,
        cex.main=2,
        cex.sub=2)

pos<-barplot(klm2,plot=FALSE)

barplot(klm2,names.arg=FALSE)
text(x=as.numeric(pos),
     y=as.numeric(klm2)+500,
     labels=c('e1','e2','e3',
               'e4','e5','e6'),
     xpd=T)

##### 
tab<-xtabs(~GJ2+KLASA_MIEJSCOWOSCI,
           data=gosp)
summary(tab)
chisq.test(tab)
barplot(tab)
barplot(prop.table(tab,2),
        col=paleta,
        main='Tytuł',
        sub='Stopka',
        names.arg=c('e1','e2','e3',
                    'e4','e5','e6'))
legend(x='right',
      legend=c('Nie mam takich zbiorów','do 25szt.','26-50szt.',
      '51-100szt.','101-500szt.',
      'ponad 500szt.'),
      fill=paleta,
      title='Ile jest (w przybliżeniu)\n w Państwa domu książek?',
      bty='n',
      cex=0.7)

##### 
plot(tab,col=paleta)
mosaicplot(tab,col=paleta,
           xlab='Liczba książek',
           ylab='Klasa miejscowości',
           main='tytuł',
           sub='stopka',
           off=1)

##### 
par(xpd=F)
plot(x=gosp$fdoch_m_osoba_ekw,
     y=gosp$gdoch_m_osoba_ekw,
     xlim=c(0,20000),
     ylim=c(0,20000),
     xlab='2011r',
     ylab='2013r')
abline(a=0,b=1,col='red')

#####
boxplot(gdoch_m_osoba_ekw~KLASA_MIEJSCOWOSCI,data=gosp)





















