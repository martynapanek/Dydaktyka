### comparison in time
library(XML)
uname <- 'http://www.bankier.pl/wiadomosc/Raport-z-rynku-mieszkan-kwiecien-2014-3101466.html'

tables <- readHTMLTable(doc = uname,encoding='utf-8',header = T)
str(tables,1)
tables
