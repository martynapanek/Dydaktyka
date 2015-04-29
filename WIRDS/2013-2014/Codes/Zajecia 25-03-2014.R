load('Course Materials/WIRDS/DataSets/DiagnozaGosp.RData')

library(ggplot2)
library(scales)


gosp2013<-gosp[gosp$WAGA_GD_2013>0 & 
                 !is.na(gosp$WAGA_GD_2013),]

qplot

## docs.ggplot2.org

qplot(x=adoch_os_m_05,
      y=gdoch_m_osoba_ekw,
      data=gosp2013[,c('adoch_os_m_05','gdoch_m_osoba_ekw')],     geom='point')

p<-qplot(x=adoch_os_m_05,
         y=gdoch_m_osoba_ekw,
         data=gosp2013[,c('adoch_os_m_05','gdoch_m_osoba_ekw')],geom='point')

p

summary(p)

last_plot()

####
p<-qplot(x=adoch_os_m_05,
      y=gdoch_m_osoba_ekw,
      data=gosp2013[,c('adoch_os_m_05','gdoch_m_osoba_ekw')],
      geom=c('point','smooth'))

summary(p)



p<-qplot(x=adoch_os_m_05,
         y=gdoch_m_osoba_ekw,
         data=gosp2013[,c('adoch_os_m_05','gdoch_m_osoba_ekw','KLASA_MIEJSCOWOSCI')],
         geom='point',
         facets=.~KLASA_MIEJSCOWOSCI)

p + ylim(0,7500) + ylab('Dochód w 2014r.')



#######
gosp2013$KLM<-factor(gosp2013$KLASA_MIEJSCOWOSCI,
                     levels=1:6,
                     labels=c('500+','200-500',
                              '100-200','20-100',
                              '20 i mniej','wies'),
                     ordered=T)
table(gosp2013$KLM)


v<-qplot(x=KLM,
         y=gdoch_m_osoba_ekw,
    geom='boxplot',
    data=gosp2013[,c('KLM','gdoch_m_osoba_ekw')])

v + xlab('Klasa miejscowisci') +
    ylab('Dochód gospodarstwa') 

##### L.OSOB_2013 - liczby osób w gospodarstwie domowym

qplot(y=L.OSOB_2013,
      x=KLM,
      data=gosp2013[,c('KLM','L.OSOB_2013')],
      geom=c('boxplot','violin'))

qplot(y=gdoch_m_osoba_ekw,
      x=KLM,
      data=gosp2013[,c('KLM','gdoch_m_osoba_ekw')],
      geom='boxplot') + scale_y_log10()
















library(RColorBrewer)

gosp2013<-gosp[!is.na(gosp$WAGA_GD_2013) & gosp$WAGA_GD_2013>0,]

qplot(x=adoch_os_m_05,y=gdoch_m_osoba_ekw,data=gosp2013,geom='point')
qplot(x=WOJEWODZTWO,data=gosp2013,geom='bar')
qplot(x=reorder(WOJEWODZTWO,WOJEWODZTWO,length),data=gosp2013,geom='bar')
