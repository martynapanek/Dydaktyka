
# packages ----------------------------------------------------------------

library(XLConnect)
library(stringi)
library(tidyr)
library(dplyr)

fname <- 'REMA/datasets/mieszkania_91_15.xls'
doc <- loadWorkbook(fname)
getSheets(doc)
dane <- readWorksheet(doc,'91-13',startRow = 1,endRow = 8) %>% tbl_df()

names(dane)[1] <- 'variable'

names(dane)[2:ncol(dane)] <- dane[2,2:ncol(dane)] %>% as.character(.) %s+% '_' %s+% 
  (dane[1,2:ncol(dane)] %>%  as.character(.) %>% stri_replace_all_fixed(.,'-','_'))

buildings_data <- dane %>%
  .[3:nrow(.),] %>%
  gather(quarter,value,-variable) %>%
  separate(quarter,c('year','month'),extra = 'merge') %>%
  dplyr::filter(variable !='OGÓŁEM')  %>%
  spread(month,value) %>%
  mutate_each(funs(as.numeric(.)),I:I_XII) %>%
  select(variable,year,I, I_II, I_III, I_IV, I_V, I_VI, I_VII, I_VIII, I_IX, I_X, I_XI, I_XII)

for (i in 3:(ncol(buildings_data)-1)) {
  buildings_data[,i+1] <- buildings_data[,i+1] - rowSums(buildings_data[,3:i])
}

buildings_data %>%
  gather(month,value,-variable,-year) %>%
  unite(year_month,year,month,sep='-') %>%
  group_by(variable) %>%
  mutate(cumul = cumsum(value)) %>%
  ggvis(x=~year_month,y=~cumul,stroke=~variable) %>%
  layer_lines()

save(buildings_data,file='REMA/datasets/building_data.rda')


