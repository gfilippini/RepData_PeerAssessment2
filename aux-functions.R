
## this function downloads and unzips the file

read_stormdata <- function(url,nameout){
    url1<-url
    download.file(url1,nameout)
    bunzip2(nameout)
    
}

data<-read.csv("stormdata.csv")
vars<-c("BGN_DATE","EVTYPE","FATALITIES","INJURIES","PROPDMG","PROPDMGEXP","CROPDMG","CROPDMGEXP")
data$year<-as.numeric(format(as.Date(data$BGN_DATE,"%m/%d/%Y"),"%Y"))

url1 <- "http://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"  
download.file(url1, "activityData.zip", mode="wb") 
unzip("activity.zip", overwrite=T)