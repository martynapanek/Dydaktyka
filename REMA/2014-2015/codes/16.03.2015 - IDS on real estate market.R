### webscraping
library(XML)
library(RCurl)
library(stringi)
library(ggvis)
library(dplyr)

# regular expressions -------

a <- 'born 2000.01.03 in the city something'

stri_extract_all_regex(str = a,
                       pattern = '[0-9]')
stri_extract_all_regex(str = a,
                       pattern = '[0-9]+')

stri_extract_all_regex(str = a,
                       pattern = '\\d')

stri_extract_all_regex(str = a,
                       pattern = '\\d+')

stri_extract_all_regex(str = a,
                       pattern = '.')

stri_extract_all_regex(str = a,
                       pattern = '\\.')

stri_extract_all_regex(str = a,
                       pattern = '\\d+\\.')

stri_extract_all_regex(str = a,
                       pattern = '\\d{2,}\\.')

stri_extract_all_regex(str = a,
    pattern = '\\d{2,}\\.\\d{0,2}\\.\\d{2,}')

b <- 'price is 200 000.00 ZŁ'

stri_extract_all_regex(str = b,
        pattern = '\\d+(\\,)?')

stri_extract_all_regex(str = b,
                pattern = '\\d+([:punct:]\\d+)?')



# webscraping -------------------------------------------------------------

morizon <- 'http://www.morizon.pl/statystyki/112014/mieszkania-sprzedaz-Poznan'


doc <- getURL(morizon,encoding='UTF-8')
class(doc)

### year
moriz_year <- stri_extract_all_regex(
  str = doc,
  pattern = 'newDate\\.setYear\\(\\d+\\)',
  simplify = T
) %>% 
  as.character() %>%
  gsub('\\D','',.)

### month
moriz_month <- stri_extract_all_regex(
  str = doc,
  pattern = 'newDate\\.setMonth\\(\\d+\\)',
  simplify = T
) %>% 
  as.character() %>%
  gsub('\\D','',.) %>%
  as.numeric() 

### date
moriz_day <- stri_extract_all_regex(
  str = doc,
  pattern = 'newDate\\.setDate\\(\\d+\\)',
  simplify = T
) %>% 
  as.character() %>%
  gsub('\\D','',.)

moriz_prices <- stri_extract_all_regex(
  str = doc,
  pattern = 'visits\\: \\d{1,5}',
  simplify = T
) %>% 
  as.character() %>%
  gsub('\\D','',.)

morizon_data <- 
  data_frame(ymd = as.Date(paste(moriz_year,
                                 moriz_month+1,
                                 moriz_day,
                                 sep='-')),
             prices = as.numeric(moriz_prices))



morizon_data %>%
ggvis(x=~ymd,y=~prices) %>%
  layer_lines()

