#### moj komentarz ####

A <- 10
A
a

class(A)

#### jeszcze raz deklaruję obiekt ####
A <- 'geomarketing'
class(A)

#### tworzymy wektory ####

v1 <- c(1,2,3,4,5,6)
class(v1)
is.vector(v1)
is.numeric(v1)
is.complex(v1)

v2 <- 1:6

all.equal(v1,v2)
v1 == v2

#### tworzymy sekwencję wektorów  ####
v3 <- seq(from = 10,to = 20,by = 0.25)
v3

rep(x = 1, times = 10)
rep(x = 1:3, times = 10)
rep(x = 1:3, each = 10)

#### tworzymy wektory pseudolosowe ####
set.seed(123)
v4 <- rnorm(1000)
summary(v4)
hist(v4)
plot(density(v4))

sample(x = 1:1000,size = 10)
sample(x = 1:49, size = 6)

v5 <- sample(x = c('Tak','Nie','Nie wiem'),
             size = 10000,
             replace = T,
             prob = c(0.6, 0.3, 0.1))

table(v5)
prop.table(table(v5))

#### tworzymy wektor typu factor ####

v6 <- sample(x = c(1,2,99),
             size = 1000,
             replace = T,
             prob = c(0.6, 0.3, 0.1))

v6_f <- factor(x = v6,
               levels = c(1,2,99),
               labels = c('Tak','Nie','Nie wiem'))
summary(v6_f)
class(v6_f)
is.numeric(v6_f)
is.factor(v6_f)
is.character(v6_f)

as.numeric(v6_f)
str(v6_f)

#### tworzymy macierze ####
m1 <- matrix(nrow = 5, ncol = 3)
m1

m1[1,1] <- 10
m1
m1[1,2] <- 'text'
m1

m1[2,] <- 1:3
m1

m1[3,] <- 1:4
m1

colnames(m1) <- paste('k',1:3,sep='')
m1

rownames(m1) <- paste0('w',1:5)
m1

dim(m1)

str(m1)

attributes(m1)

attr(m1,'komentarz') <- 'macierz tworzona na zajeciach'

attributes(m1)

attr(m1,'komentarz') <- NULL

attributes(m1)

#### obliczenia na macierzach ####
m2 <- matrix(data = sample(1:100,25,T),
             ncol = 5,
             nrow = 5)
m2

t(m2) ### transpozycja
solve(m2) ### odwracanie macierzy
det(m2) ### wyznacznik
diag(m2) ### diagonalna
rowSums(m2) ### suma dla wierszy po kolumnach
colSums(m2) ### suma dla kolumn po wierszach
sum(m2) ### suma elementów

m2 %*% m2 ### mnożenie macierzy
t(m2) %*% m2 ### A'A
crossprod(m2) ### A'A = t(A) %*% A
tcrossprod(m2) ### AA' = A %*% t(A)

