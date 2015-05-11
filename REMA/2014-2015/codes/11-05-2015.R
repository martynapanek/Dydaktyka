library(lme4)
library(PBImisc)
library(dplyr)
data('apartments')
apartments <- tbl_df(apartments)
head(apartments)
names(apartments)

boxplot(transaction.price~district,
        data = apartments)


library(ggplot2)

ggplot(data = apartments,
       aes(x = surface,
           y = transaction.price,
           colour = district,
           group = district)) +
  #geom_point() + 
  geom_smooth(method = 'lm',se=FALSE)


#### random intercept model
model1 <- lm(transaction.price~surface,
             data = apartments)
summary(model1)


model2 <- lmer(transaction.price~surface + 
                 ( 1 | district ),
               data = apartments)

summary(model2)

ranef(model2)

var(fitted(model1))/var(apartments$transaction.price)
var(fitted(model2))/var(apartments$transaction.price)
