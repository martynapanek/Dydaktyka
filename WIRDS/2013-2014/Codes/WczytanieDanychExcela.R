## wczytanie danych XLS do excela
## dwa sposoby pakiet xlsx i XLConnect
options(java.parameters = "-Xmx1024m")

dane<-'Course Materials/WIRDS/DataSets/gospodarstwa.xls'
## pierwszy sposob
library(xlsx)
zb<-read.xlsx(dane,sheetIndex=1)

### drugi sposob
library(XLConnect)
zb<-readWorksheetFromFile(dane,sheet=1)

head(zb)
summary(zb$dochg)
summary(zb)

library(mi)
d
newData<- mi(zb, info=d, check.coef.convergence=TRUE, 
             add.noise=noise.control(post.run.iter=10))

str(zb)

converged(newData,check='data')
IMP.bugs1 <- bugs.mi(newData, check = "data")
plot(IMP.bugs1)
plot(newData)

wynik<-mi.data.frame(newData)


#### 
library(yaImpute)

a<-impute(zb)
