
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


totalecon_dmg<-data.frame(tapply(data$econ_dmg, data$year,sum))
names(totalecon_dmg)<-"t_econ_dmg"
totalecon_dmg$year<-as.integer(row.names(totalecon_dmg))
ggplot(totalecon_dmg) + aes(x=year,y=t_econ_dmg) + geom_line(color="blue", size=1)+ expand_limits(x=2000)
ev_dmg<-data.frame(tapply(data$econ_dmg, as.character(data$EVTYPE), sum,na.rm=T))
names(ev_dmg)<-"ev_dmg"
ev_dmg$type<-as.character(row.names(ev_dmg))

ev_dmg <- ev_dmg[order(-ev_dmg$ev_dmg),]
row.names(ev_dmg)<-NULL

plot_ec_dmg<-ggplot(data = ev_dmg[1:10, ], aes(x = reorder(type,-ev_dmg), y = ev_dmg)) + xlab("Event Type") + ylab("Total Impact")

plot_ec_dmg <- plot_ec_dmg + geom_bar(fill = "darkgreen", stat = "identity") + theme(axis.text.x = element_text(angle = 90, hjust = 0.5, vjust = 1))

hh_dmg<-data.frame(tapply(data$human_inj, as.character(data$EVTYPE), sum,na.rm=T))
names(hh_dmg)<-"hh_dmg"
hh_dmg$type<-as.character(row.names(hh_dmg))
hh_dmg <- hh_dmg[order(-hh_dmg$hh_dmg),]

plot_hh_dmg<-ggplot(data = hh_dmg[1:10, ], aes(x = reorder(type,-hh_dmg), y = hh_dmg)) + xlab("Event Type") + ylab("Total Impact")

plot_hh_dmg <- plot_hh_dmg + geom_bar(fill = "red", stat = "identity") + theme(axis.text.x = element_text(angle = 90, hjust = 0.5, vjust = 1))

