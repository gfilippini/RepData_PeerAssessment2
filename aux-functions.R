
## this function downloads and unzips the file

read_stormdata <- function(url,nameout){
    url1<-url
    download.file(url1,destfile=nameout)
    bunzip2(nameout)
    
}

library(R.utils)
data<-read.csv("stormdata.csv")
vars<-c("BGN_DATE","EVTYPE","FATALITIES","INJURIES","PROPDMG","PROPDMGEXP","CROPDMG","CROPDMGEXP")
data$year<-as.numeric(format(as.Date(data$BGN_DATE,"%m/%d/%Y"),"%Y"))
a<-data[data$year>=2001,]
xtabs(~a$PROPDMGEXP,drop.unused.levels=T)
a$human_inj<-a$INJURIES+a$FATALITIES
a$crop_mult<-ifelse(a$CROPDMGEXP=='K',3,ifelse(a$CROPDMGEXP=='M',6,ifelse(a$CROPDMGEXP=='B',9,0)))
a$prop_mult<-ifelse(a$PROPDMGEXP=='K',3,ifelse(a$PROPDMGEXP=='M',6,ifelse(a$PROPDMGEXP=='B',9,0)))
a$prop_dmg<-a$PROPDMG*10^a$prop_mult+a$CROPDMG*10^a$crop_mult
url1 <- 'http://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2'  
download.file(url1, "activityData.zip", mode="wb") 
unzip("activity.zip", overwrite=T)