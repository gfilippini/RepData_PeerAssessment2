
## this function downloads and unzips the file

read_stormdata <- function(url,nameout){
    url1<-url
    download.file(url1,nameout)
    bunzip2(nameout)
    
}

url1 <- "http://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"  
download.file(url1, "activityData.zip", mode="wb") 
unzip("activity.zip", overwrite=T)