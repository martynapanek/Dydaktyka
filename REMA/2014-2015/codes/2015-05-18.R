library(spgwr)
library(foreign)
library(dplyr)
library(tidyr)
library(ggmap)
library(ggplot2)
library(AICcmodavg)

baltimore <- read.dbf('~/Documents/Projects/RProjects/Dydaktyka/REMA/2014-2015/datasets/baltim.dbf')

head(baltimore)

simple_model <- lm(PRICE ~ NROOM + NBATH + GAR + AGE + SQFT, data = baltimore)
summary(simple_model)


plot(x = baltimore$PRICE,
     y = simple_model$fitted.values,
     main = 'Comparison of observed values (X) and prediction from LW (Y)',
     xlab = 'Observed',
     ylab = 'lm prediction')
abline(a=0,b=1,col='red')


### setting the bandwidth (b)

bandwidth <- gwr.sel(
  formula = PRICE ~ NROOM + NBATH + 
    GAR + AGE + SQFT,
  data = baltimore,
  coords = cbind(
    baltimore$X,
    baltimore$Y))

### estimate GWR model

model <- gwr(
  formula = PRICE ~ NROOM + NBATH + 
    GAR + AGE + SQFT,
  data = baltimore,
  coords = cbind(
    baltimore$X,
    baltimore$Y),
  bandwidth = bandwidth)

print(model)

model <- gwr(
  formula = PRICE ~ NROOM + NBATH + 
    GAR + AGE + SQFT,
  data = baltimore,
  coords = cbind(
    baltimore$X,
    baltimore$Y),
  bandwidth = bandwidth, 
  hatmatrix = TRUE, ## hat matrix
  se.fit = TRUE, ## standard errors
  cl = 8, ## parallel computing
  predictions = TRUE) ## save predictions

print(model)

## compare results

plot(x = baltimore$PRICE,
     y = model$SDF@data$pred,
     main = 'Comparison of observed values (X) and prediction from GWR (Y)',
     xlab = 'Observed',
     ylab = 'GWR prediction')
abline(a=0,b=1,col='red')

plot(x = simple_model$fitted.values,
     y = model$SDF@data$pred,
     main = 'Comparison of prediction from LM (X) and GWR (Y)',
     xlab = 'LM prediction',
     ylab = 'GWR prediction')
abline(a=0,b=1,col='red')


### visualisation


str(model,1)
str(model$SDF,2)
str(model$SDF@data,1)

result <- model$SDF@data

hist(result$AGE)
hist(result$NROOM)

### ploting results
result$X <- baltimore$X
result$Y <- baltimore$Y

ggplot(
  data = result,
  aes(x = X,
      y = Y,
      colour = NBATH)) + 
  geom_point(size=10)


result %>%
  select(`(Intercept)`:SQFT,X,Y) %>%
  gather(var,val,-X,-Y) %>%
  group_by(var) %>%
  mutate(val = scale(val)) %>%
  ggplot(data = .,
         aes(x = X,
             y = Y,
             colour = val)) +
  geom_point(size = 5) +
  facet_wrap(~var) +
  theme_bw()

### how much did we gain?
cat('LM AICc:', AICc(simple_model),
    'GWR AICc:', model$results$AICc)


