## hedonic regression
library(dplyr)
library(lubridate)
library(readxl)
library(ggplot2)
library(readr)
library(tidyr)

sheets <- excel_sheets('REMA/datasets/ceny_mieszkan.xls')
indicators <- read_excel('REMA/datasets/ceny_mieszkan.xls',
                         sheet = 'indexes')
prices <- read_excel('REMA/datasets/ceny_mieszkan.xls',
                     sheet = 'prices')

save(indicators,prices,file='REMA/datasets/nbp_data.rda')

warsaw <- read_csv(file = 'REMA/datasets/apartments_warsaw.csv')


# simple vis of hedonic index ----------------------------------

ind <- indicators %>%
  gather(city,index,-Quarter,-Type) %>%
  group_by(Type,city) %>%
  mutate(ID = row_number(),
         ID = as.factor(ID))


ggplot(data = ind,
       aes(x = ID,
           y = index,
           colour = Type,
           group = Type)) +
  geom_point() +
  geom_line() +
  facet_wrap(~city) +
  geom_hline(yintercept=100) +
  theme_bw()

# our calculations

### regression
reg <- warsaw %>%
  mutate(ymd = ymd(paste0(year,'/',month,'/01')),
         quarter = quarter(ymd,with_year=T)) %>%
  group_by(quarter) %>%
  do(models = lm(
    log(offer.price) ~ log(surface) + district + n.rooms + floor + 
      construction.date + type,data = .
    ))

### fitted values
d <- reg %>%
  do(m = mean(fitted(.$models),na.rm=T),
     med = median(fitted(.$models)),
     n = length(fitted(.$models)))

### hedonic index
d$m %>%
  unlist() %>%
  exp() %>%
  data.frame(hedonic_price = .) %>%
  as_data_frame() %>%
  mutate(ind = lag(hedonic_price,k=1),
         index = hedonic_price/ind*100,
         yearly_index = hedonic_price/474732.3*100,
         n = unlist(d$n))






