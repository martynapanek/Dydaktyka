#### 
library(readxl)
library(dplyr)
library(tidyr)
library(stringi)



### files with transactions

files_list <- list.files(
  path = '~/Documents/Uczelnia/Rozne/GeoPoz - dane/ZG-OUG.41021.2.2.2015/',
  pattern = 'wt.+\\.xls$',
  full.names = TRUE)


### read all files
secondary <- lapply(files_list,read_excel,skip=2)
length(secondary)
str(secondary,max.level = 1)

col_names <- sapply(secondary,names)
table(col_names)

sapply(secondary,names) %>%
  table(.)

col_classes <- sapply(secondary,sapply,class)
View(col_classes)

secondary[[7]]$`Cena transakcji [PLN]` <- 
  as.numeric(secondary[[7]]$`Cena transakcji [PLN]`)


# merging datasets --------------------

bind_cols()
bind_rows()
rbind_all() / rbind_list()

all_data <- bind_rows(secondary)
dim(all_data)

all_data[1:100,c('aaf','asfas')]

# dplyr intro -----------------------------
re_sec <- all_data %>%
  select(`Nr transakcji`:`Cena za nieruchomość [PLN]`,
         `Funkcja podstawowa lokalu`:`Cena m2 lokalu [PLN]`) %>%
  rename(trans_id = `Nr transakcji`,
         trans_date = `Data transakcji`,
         trans_total_price = `Cena transakcji [PLN]`,
         trans_re_id = `Nieruchomość`,
         trans_total_price_re = `Cena za nieruchomość [PLN]`,
         dwelling_prim_func = `Funkcja podstawowa lokalu`,
         dwelling_sec_func = `Funkcja drugorzędna lokalu`,
         dwelling_participation = `Udział w prawie do lokalu`,
         dwelling_rooms = `Liczba izb`,
         dwelling_floor_area = `Powierzchnia lokalu [m2]`,
         dwelling_floor_number = `Kondygnacja`,
         dwelling_additional_number = `Liczba pomieszczeń przynależn.`,
         dwelling_additional_fa = `Powierzchnia pom. przyn. [m2]`,
         dwelling_price  = `Cena za lokal [PLN]`,
         dwelling_price_m2 = `Cena m2 lokalu [PLN]`) %>% 
  mutate_each(funs(as.numeric(.)),
              trans_total_price_re,
              dwelling_rooms:dwelling_price_m2) %>%
  mutate(trans_date = as.Date(trans_date,format='%d-%m-%Y'))


# all in all -------------------------------

data <- list.files(
  path = '~/Documents/Uczelnia/Rozne/GeoPoz - dane/ZG-OUG.41021.2.2.2015/',
  pattern = 'wt.+\\.xls$',
  full.names = TRUE) %>%
  lapply(., read_excel,skip=2) 

data[[7]]$`Cena transakcji [PLN]` <- 
  as.numeric(data[[7]]$`Cena transakcji [PLN]`)

data %>%
  bind_rows() %>%
  select(`Nr transakcji`:`Cena za nieruchomość [PLN]`,
         `Funkcja podstawowa lokalu`:`Cena m2 lokalu [PLN]`) %>%
  rename(trans_id = `Nr transakcji`,
         trans_date = `Data transakcji`,
         trans_total_price = `Cena transakcji [PLN]`,
         trans_re_id = `Nieruchomość`,
         trans_total_price_re = `Cena za nieruchomość [PLN]`,
         dwelling_prim_func = `Funkcja podstawowa lokalu`,
         dwelling_sec_func = `Funkcja drugorzędna lokalu`,
         dwelling_participation = `Udział w prawie do lokalu`,
         dwelling_rooms = `Liczba izb`,
         dwelling_floor_area = `Powierzchnia lokalu [m2]`,
         dwelling_floor_number = `Kondygnacja`,
         dwelling_additional_number = `Liczba pomieszczeń przynależn.`,
         dwelling_additional_fa = `Powierzchnia pom. przyn. [m2]`,
         dwelling_price  = `Cena za lokal [PLN]`,
         dwelling_price_m2 = `Cena m2 lokalu [PLN]`) %>% 
  mutate_each(funs(as.numeric(.)),
              trans_total_price_re,
              dwelling_rooms:dwelling_price_m2) %>%
  mutate(trans_date = as.Date(trans_date,format='%d-%m-%Y'))







