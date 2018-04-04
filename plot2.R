#load libraries
library(data.table)
library(dplyr)
library(ggplot2)

#read the data
newFile <- read.table("C:\\Users\\rpande35\\Desktop\\household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE)
#convert date into date class
newFile$Date<-as.Date(newFile$Date,format = "%d/%m/%Y")

#subsetting the two dates
d1<-newFile[newFile$Date== as.Date("2007-02-01"),]

d2<-newFile[newFile$Date ==as.Date("2007-02-02"),]
#merging the dataframes
subsetted <- rbind(d1,d2)
dim(subsetted)  
#crrating datetime column merging date and time
subsetted$datetime<-as.POSIXct(paste(subsetted$Date, subsetted$Time), format="%Y-%m-%d %H:%M:%S")

  #drawing plot2
dev.copy(png,'C:\\Users\\rpande35\\Desktop\\plot2.png',width = 480, height = 480)
g<-ggplot(data=subsetted,aes(x=subsetted$datetime,y=Global_active_power))+geom_line()
g<-g+scale_x_datetime(labels=date_format("%Y-%m-%d %H:%M:%S"),date_labels = "%a ", date_breaks = "1 day")
g<-g+xlab(".")+ylab("Global Active Power(kilowatts)")+ggtitle("Plot 2")
g
dev.off()