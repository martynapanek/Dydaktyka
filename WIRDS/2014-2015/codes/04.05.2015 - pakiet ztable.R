# wczytanie pakietów
library(ztable)
library(sjPlot)
# wczytanie danych
gospodarstwa <- read_spss(path = "C:/Users/KS_MS/Desktop/FG/Zajêcia 2015/Wirds/Tabele w Sjplot/gosp.sav",  
                          enc = "cp1250",           
                          autoAttachVarLabels = TRUE)

view_spss(gospodarstwa,encoding = "cp1250")

labels.values <- get_val_labels(gospodarstwa)

labels.variables <- get_var_labels(gospodarstwa)

gospodarstwa <- set_val_labels(gospodarstwa, labels.values)

gospodarstwa <- set_var_labels(gospodarstwa, labels.variables)


#Zadanie 1

options(ztable.type="latex")
(z=ztable(head(gospodarstwa[,1:6])))

#Zadanie 2

(z=ztable(head(gospodarstwa[,1:6]),align="ccccccc"))

# Zadanie 3

cgroup=c("Zmienna 1 i 2","Zmienna 3 i 4","Zmienna 5 i 6")
n.cgroup=c(2,2,2)
z=addcgroup(z,cgroup=cgroup,n.cgroup=n.cgroup)
z

# Zadanie 4
model <- lm(wydg~dochg+los, data=gospodarstwa)
ztable(model)

# Zadanie 5

model1 <- lm(klm~wydg,data=gospodarstwa)
z <- anova(model1)
ztable(z)

# Zadanie 6

z1=ztable(head(gospodarstwa[,1:6]),zebra=2)
z1

# Zadanie 7

z1=ztable(head(gospodarstwa[,1:6]),zebra=2)
print(z1,zebra.type=2)

# Zadanie 8

t1=head(gospodarstwa,10)[,c(1,3,5)]
t2=tail(gospodarstwa,10)[,c(1,3,5)]
t=cbind(t1,t2)
z=ztable(t,caption="Tabela 1. Pierwszych 10 i ostatnich 10 wierszy")
cgroup=c("Pierwszych 10","Ostatnich 10")
n.cgroup=c(3,3)
z=addcgroup(z,cgroup=cgroup,n.cgroup=n.cgroup)
z