# program z zajęć 24.10.2014

table(droplevels(school2009subset$CNT))

zb1 <- subset(x = school2009subset,
              select = c(CNT, SC04Q01))
head(zb1)
tail(zb1)

zb1$CNT <- droplevels(zb1$CNT) 
### tabela przestawna
xtabs(~CNT+SC04Q01, zb1)


# losowanie proste bez zwaracania -----------------------------------------

## identyfikatory
id <- 1:nrow(school2009subset)
## wielkość populacji
N <- nrow(school2009subset)
## wielkość próby
n <- 200

set.seed(123)
id_s <- sample(x = id,
               size = n)
sch_s <- zb1[ id_s, ]
table(sch_s$CNT)


# losowanie ze zwracaniem -------------------------------------------------

set.seed(123)
id_s <- sample(x = id,
               size = n,
               replace = T)

length( unique( id_s ) )
sort( table( id_s ) )

sch_sz <- zb1[id_s,]


# losowanie zespołowe -----------------------------------------------------
set.seed(123)
id_s <- sample(x = id,
               size = n)
sch_s <- school2009subset[ id_s, 'SCHOOLID']
stu_s <- student2009subset[ 
            student2009subset$SCHOOLID %in% sch_s, ]
dim(stu_s)

length(unique(stu_s$SCHOOLID))


# losowanie zespołowe dla Polski ------------------------------------------
### podzbiór szkoł z Polski
sch_pol <- subset(school2009subset,
                  CNT == 'Poland')

### podzbór uczniów z Polski
stu_pol <- subset(student2009subset,
                  CNT == 'Poland')
dim(sch_pol)
dim(stu_pol)

### losujemy szkoły
set.seed(123)
ids <- sample(x = sort(sch_pol$SCHOOLID),
              size = 50)
ucz <- stu_pol[stu_pol$SCHOOLID %in% ids,]
dim(ucz)
length(unique(ucz$SCHOOLID))



# losowanie warstwowe -----------------------------------------------------
strat_samp <- function(data,
                       samp_size,
                       ...) {
  
  ### sample function 
  samp_one <- function(x) {
    sample(1:length(x),length(x))
  }
  
  ### function
  ds <- data %>%   
    group_by(...) %>%
    mutate(N_strat = n(),
           los = samp_one(N_strat)) %>%
    group_by() %>%
    mutate(N = n(),
           n_samp = round(N_strat/N*samp_size),
           filter = los <= n_samp) %>%
    filter(filter) %>%
    select(-(N_strat:filter))
  return(ds)
}

library(dplyr)

## SC02Q01 - typ szkoly (pub/priv)
table(sch_pol$SC02Q01)
## SC04Q01 - wielkość miasta
table(sch_pol$SC04Q01)


sch_w <- strat_samp(sch_pol,100,
           SC02Q01,SC04Q01)
## próba
prop.table(table(sch_w$SC02Q01))
## populcja
prop.table(table(sch_pol$SC02Q01))

## próba
prop.table(table(sch_w$SC04Q01))
## populcja
prop.table(table(sch_pol$SC04Q01))










