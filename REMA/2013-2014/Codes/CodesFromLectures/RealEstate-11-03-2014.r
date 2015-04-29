
# setting working directory;
setwd('C:/Users/L419Kst/teacher/REMA/')

## declare sheetnames
sheetN<-c('Kody','DANE','Aglomer','Teren')

## assigining object that stores given path
fpath<-getwd()

### loading package XLConnect
options(java.parameters = "-Xmx2048m") ## additional line to avoid problems with using java
library(XLConnect)

### there is function called readWorksheetFromFile but we will shorten it
### as in SAS macro
### in result we get list with all sheets

importdata<-function(wb,
                     path=fpath,
                     sheetNames=sheetN){
  wbName<-paste0(path,'/',wb,'.xlsx')
  wbData<-loadWorkbook(wbName)
  out<-readWorksheet(wbData,sheet=sheetNames)
  return(out)
}

### example usage

imported<-importdata('Wyniki')


