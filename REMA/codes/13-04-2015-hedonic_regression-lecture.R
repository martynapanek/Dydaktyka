library(ggplot2)
#install.packages('dplyr')
library(dplyr)

warsaw <- read.csv('REMA/datasets/apartments_warsaw.csv')

warsaw %>% count(district)
table(warsaw$district)

warsaw$district_dummy <- 
  ifelse(warsaw$district %in% 
           c('Praga Polnoc','Praga Poludnie','Zoliborz','Srodmiescie','Mokotow','Wola','Ochota','Targowek'),1,0)

table(warsaw$district_dummy)

### vector of names

colNames <- c('year',
              'month',
              'surface',
              'n.rooms',
              'construction.date',
              'transaction.price',
              'district_dummy')
length(colNames)
## create subset
warsaw_subset <- warsaw[,colNames]
## check how many missing values we have
sum(!complete.cases(warsaw_subset))
### take only complete cases
warsaw_subset <- warsaw_subset[complete.cases(warsaw_subset),]
### basic info aboutd data set
summary(warsaw_subset)
dim(warsaw_subset)

### lm
m1 <- lm(log(transaction.price) ~ 
           I(sqrt(surface)) + 
           n.rooms + construction.date + 
           district_dummy, 
         data = warsaw_subset)
car::vif(m1)
summary(lm(log(transaction.price) ~ 
             I(sqrt(surface)) + 
             n.rooms + construction.date + 
             district_dummy, 
           data = warsaw_subset))

#### 
warsaw_subset$quarter <- 
  cut(x = warsaw_subset$month,
      breaks = c(0,3,6,9,12),
      labels = c('Q1','Q2','Q3','Q4'))

table(warsaw_subset$year,warsaw_subset$quarter)

### building models

m2007Q3 <- lm(
  log(transaction.price) ~ 
            I(sqrt(surface)) + 
            n.rooms + 
            construction.date + 
            district_dummy, 
      data = warsaw_subset,
      subset = year=='2007' & quarter=='Q3'
  )
### subset for m2007Q2
m2007Q2 <- subset(warsaw_subset,
                  year=='2007' & quarter=='Q2')
### sum of log(transaction price) for 2007Q2

sum_price_2007Q2 <- sum(log(m2007Q2$transaction.price))
sum_price_2007Q3 <- sum(predict(m2007Q3,m2007Q2))
Index_2007Q3_Q2 <- sum_price_2007Q3/sum_price_2007Q2*100



