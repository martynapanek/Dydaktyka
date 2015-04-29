### installing packages 
#install.packages(c('XML','RCurl','httr'),dependencies=T)

### loading packages that we need 
library(XML)
library(RCurl)

### example on using function to get tables from html webs
url<-'http://en.wikipedia.org/wiki/Ski_jumping_World_Cup'

### reading tables usiing readHTMLTable
tab<-readHTMLTable(doc=url,header=T)
#### see the structure of the object
str(tab,max.level=1)

### geting to the first element of list
tab[[1]]


#### now we will have example on otodom web page
#### otodom.pl

### link for offers on flats in poznan
pzn<-'http://otodom.pl/index.php?mod=listing&source=context&objSearchQuery.OfferType=sell&objSearchQuery.ObjectName=Flat&objSearchQuery.Country.ID=1&objSearchQuery.Province.ID=15&objSearchQuery.District.ID=462&objSearchQuery.CityName=Pozna%C5%84&objSearchQuery.Distance=0&objSearchQuery.QuarterName=&objSearchQuery.StreetName=&objSearchQuery.LatFrom=&objSearchQuery.LatTo=&objSearchQuery.LngFrom=&objSearchQuery.LngTo=&objSearchQuery.PriceFrom=&objSearchQuery.PriceTo=&objSearchQuery.PriceCurrency.ID=1&objSearchQuery.PriceM2From=&objSearchQuery.PriceM2To=&objSearchQuery.PriceM2Currency.ID=1&objSearchQuery.AreaFrom=&objSearchQuery.AreaTo=&objSearchQuery.FlatRoomsNumFrom=&objSearchQuery.FlatRoomsNumTo=&objSearchQuery.FlatFloorFrom=&objSearchQuery.FlatFloorTo=&objSearchQuery.FlatBuildingType=&objSearchQuery.BuildingMaterial=&objSearchQuery.FlatFloorsNoFrom=&objSearchQuery.FlatFloorsNoTo=&objSearchQuery.BuildingYearFrom=&objSearchQuery.BuildingYearTo=&objSearchQuery.HouseFloorsNum=&objSearchQuery.MarketType=&objSearchQuery.CreationDate=&objSearchQuery.Description=&objSearchQuery.offerId=&objSearchQuery.Orderby=default&resultsPerPage=25&Search=Search&Location=wielkopolskie%2C%20Pozna%C5%84'

#### parsing webpage using html
doc<-htmlParse(pzn,encoding='UTF-8')
### check class 
class(doc)

### two functions for for XPath
# xpathApply
# xpathSApply

#### extracting prices from webpages
price<-xpathSApply(doc,'//strong[@class="od-listing_item-price"]',xmlValue)

#### extracting information on surface 
xpathApply(doc, '//div[@class="od-listing_item-numbers"]/strong[2]',xmlValue)


