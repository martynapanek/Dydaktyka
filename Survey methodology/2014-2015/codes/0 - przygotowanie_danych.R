#### przetwarzanie danych

load('/Users/MaciejBeresewicz/Documents/Projects/RProjects/PAZUR Workshop/Datasets/Raw/pisa2009subset.rdata')

library(dplyr)
library(data.table)

### dane dla szkół ---------------------
school2009 <- school2009subset %>%
                  filter(CNT=='Poland') %>%
                  select(SCHOOLID, ## identyfikator szkoły
                         SC02Q01, ## czy szkoła jest prywatna czy publiczna
                         SC04Q01, ## wielkość miasta
                         SC06Q01, ## liczba dziewczynek
                         SC06Q02, ## liczba chłopców
                         SCHSIZE ## ogólna liczba uczniów
                         )

### dane dla uczniów ---------------------

student2009 <- student2009subset %>%
                  filter(CNT == 'Poland') %>%
                  select(SCHOOLID, ## school ID
                         STIDSTD, ## student ID
                         ST04Q01, ## Płeć
                         ST21Q03, ## Liczba komputerów
                         ST22Q01, ## Liczba ksiażek                      
                         PV1MATH:PV5MATH ## Wartości do oceny zdolności z matematyki
                         )



### zapis danych ------------------------------------------------------------

save(student2009,school2009,school2009dict,student2009dict,
     file='datasets/pisa2009pol.rda')

