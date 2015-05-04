###############RAPORTY TABELARYCZNE W R###############

setwd("C:/Users/KS_MS/Desktop/FG/Zajêcia 2015/Wirds/Tabele")  
load('gospodarstwa.rda')

# Zadanie 1

table(gosp$klm)

# Zadanie 2

table(gosp$woj)

# Zadanie 3

table(gosp$woj,gosp$klm)

# Zadanie 4

table(cut(gosp$wydg,breaks=c(0,500,1000,2000,5000,10000,40000)))

# Zadanie 5

przedzialy <- quantile(gosp$wydg, probs=c(0,0.25,0.5,0.75,1),na.rm=TRUE)
table(cut(gosp$wydg,breaks=przedzialy,dig.lab=6))

# Zadanie 6

table(gosp$woj,cut(gosp$dochg,breaks=c(0,1000,5000,20000,55000),dig.lab=6))

# Zadanie 7

przedzialdoch <- fivenum(gosp$dochg)
przedzialwydg <- fivenum(gosp$wydg)
table(cut(gosp$dochg,breaks=przedzialdoch,dig.lab=5),
      cut(gosp$wydg,breaks=przedzialwydg,dig.lab=5))

# Zadanie 8

tabela <- table(gosp$klm,gosp$zut)
summary(tabela)
chisq.test(tabela)
      
# Zadanie 9

tabela <- with(gosp,table(zut,d61))
summary(tabela)
chisq.test(tabela)

# Zadanie 10

with(gosp,table(trb))

# Zadanie 11

tabela <- table(gosp$klm)
addmargins(tabela)

# Zadanie 12

tabela <- with(gosp,table(klm,trb))
addmargins(tabela)

# Zadanie 13

tabela <- with(gosp,table(woj,klm))
addmargins(tabela,FUN=list(Razem=sum,list(Min=min,Max=max,Razem=sum)))

# Zadanie 14

tabela <- with(gosp,table(zut,trb))
apply(tabela,1,sum)
apply(tabela,2,max)

# Zadanie 15

lapply(gosp[,c('zut','trb','klm')],max)

# Zadanie 16

sapply(gosp[,c('zut','trb','klm')],max)

# Zadanie 17

tabela <- table(gosp$woj,gosp$klm)

tabela_ods <- round(prop.table(tabela),4)*100

# Zadanie 18

tabela <- table(gosp$trb,gosp$klm)

tabela_odsw <- round(prop.table(tabela,1),6)*100

apply(tabela_odsw,1,sum) # sprawdzenie czy suma w wierszach jest 100%

# Zadanie 19

tabela <- table(gosp$zut,gosp$klm)
tabela_odsk <- round(prop.table(tabela,2),6)*100
apply(tabela_odsk,2,sum) # sprawdzenie czy suma w kolumnach jest 100%

# Zadanie 20

tabela <- table(gosp$d61,gosp$d348)
etykieta_w <- c('Bardzo dobra','Raczej dobra','Przeciêtna','Raczej z³a','Z³a')
etykieta_k <- c('Tak','Nie')
rownames(tabela) <- etykieta_w
colnames(tabela) <- etykieta_k

tabela_odsw <- round(prop.table(tabela,1),4)*100
rownames(tabela_odsw) <- etykieta_w
colnames(tabela_odsw) <- etykieta_k

# Zadanie 21

wydatki <- by(gosp$wydg,gosp$woj,mean, na.rm=TRUE)
str(wydatki)
dimnames(wydatki)[[1]]<-c('dolnoœl¹skie','kujawsko-pomorskie','lubelskie','lubuskie',	
                          '³ódzkie','ma³opolskie','mazowieckie','opolskie','podkarpackie',	
                          'podlaskie','pomorskie','œl¹skie','œwiêtokrzyskie','warmiñsko-mazurskie',	
                          'wielkopolskie','zachodniopomorskie')

# Zadanie 22

dochody <- by(gosp$wydg,gosp$klm,summary,na.rm)
dimnames(dochody)[[1]] <- c('500T +', '200T-500T','100T-200T',	
                            '20T-100T','-20T','Wieœ')

# Zadanie 23

srednia <- aggregate(gosp$dochg,list(gosp$zut),FUN=function(x) c(Œrednia=mean(x,na.rm=T),Sx=sd(x,na.rm=T)))
str(srednia)
srednia$Group.1 <- c('Gospodarstwo pracowników','Gospodarstwo pracowników u¿ytkuj¹cych gospodarstwo rolne',
                     'Gospodarstwo rolników','Gospodarstwo pracuj¹cych na w³asny rachunek poza gospodarstwem rolnym',
                     'Gospodarstwo emerytów','Gospodarstwo rencistów','Gospodarstwo utrzymuj¹ce siê z niezarobkowowych Ÿróde³')
