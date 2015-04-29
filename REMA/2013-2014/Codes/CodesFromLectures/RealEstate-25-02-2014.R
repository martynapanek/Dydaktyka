### using basics R functions

### classes 
class(realEstatesKWW) ## check class of object
mode(realEstatesKWW) ## check mode of object (from which given object inherits)
methods(class='data.frame') ## check methods (functions) that are assigned to given class

### basic functions 
dim(realEstatesKWW) ## check dimensions of object
a<-dim(realEstatesKWW) ## assign dimensions to object
str(a) ## check structure of object 
str(realEstatesKWW) ## check structure of data.frame
summary(realEstatesKWW) ## summary statistics and information about variables

### tabelar reports
tab1<-table(realEstatesKWW$city)
str(tab1) ### structure of tables (see attr or attributes)

### change attributes of object
attr(tab1,'dimnames')[[1]]<-c('Cracow','Warsaw','Wroclaw')

### check that our changes effected our object
tab1

### writing first function for creating table
## function - keyword for creating functions
## x - argument passed to function 
## return - informs what object is returned from function
myFunction<-function(x){
  tab<-table(x)
  return(tab)
}

### usage of function
myFunction(realEstatesKWW$city)

### developing function (add new parameter - dn) and 
## checking it exists

myFunction<-function(x,dn=NULL){
    tab<-table(x)
    
    if (!is.null(dn)){
      attr(tab,'dimnames')[[1]]<-dn
    }
    barplot(tab)
    return(tab)
}


### usage of new version of function
tab2<-myFunction(realEstatesKWW$city,dn=c('K','W','W'))










