####
library(stringr)

a<-'surface 23,45m2'

str_extract(a,'[0-9]{1,3}\\,[0-9]{1,2}')

b<-'1 pokój, rok budowy: 2000'
str_extract(b,'\\d{1,2}\\s{1}pok|kawalerka')

courseData<-transform(
  courseData,
  flatRooms=str_extract(odParam,
'\\d{1,2}\\s{1}pok|kawalerka'),
  flatYear=str_extract(odParam,'[0-9]{4}'),
  flatBlock=str_match(odParam,'blok'),
  flatFloor=str_extract(odParam,'[0-9]{1,2}\\/[0-0]{1,2}')
  )

table(courseData$flatRooms)

courseData$flatRooms<-gsub('\\D',
                           '',
courseData$flatRooms)

### clean the price
courseData$odPrice<-gsub('\\D','',
      courseData$odPrice)

class(courseData$odPrice)

courseData$odPrice<-as.numeric(courseData$odPrice)

hist(courseData$odPrice)
summary(courseData$odPrice)







