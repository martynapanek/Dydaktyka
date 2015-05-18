library(spgwr)
library(foreign)
library(dplyr)
library(tidyr)
library(ggmap)

baltimore <- read.dbf('REMA/2014-2015/datasets/baltim.dbf')

head(baltimore)

simple_model <- lm(PRICE ~ NROOM + NBATH + GAR + AGE + SQFT, data = baltimore)
summary(simple_model)

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

### visualisation

library(ggplot2)

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
  gather(var,val,-X,-Y) %>%
  group_by(var) %>%
  mutate(val = scale(val)) %>%
  ggplot(data = .,
         aes(x = X,
             y = Y,
             colour = val)) +
  geom_point(size = 5) +
  facet_wrap(~var)

### how much we gained?
var(result$pred)/var(baltimore$PRICE)


### plot results on map (however data is rescaled not to be indentified)
hdf <- get_map('Baltimore,Maryland',zoom = 12)

map <- ggmap('')

ggmap(hdf) + 
  geom_point(data = result,
             aes(x = X,
                 y = Y,
                 colour = NBATH), size=10)

