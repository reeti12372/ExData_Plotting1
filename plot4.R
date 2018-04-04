#load libraries
library(data.table)
library(dplyr)
library(ggplot2)
library(reshape2)
require(gridExtra)

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
#creating datetime column merging date and time
subsetted$datetime<-as.POSIXct(paste(subsetted$Date, subsetted$Time), format="%Y-%m-%d %H:%M:%S")


## creating sub matrix for third plot of sub metreing

#subsetting the four desired columns
d<-subsetted[,c("Sub_metering_1","Sub_metering_2", "Sub_metering_3","Global_active_power" , "datetime")]
#convert it into tall format
d <- melt(d, id.vars="datetime")

## creating plots

g1<-ggplot(data=subsetted,aes(x=subsetted$datetime,y=Global_active_power))+geom_line()
g1<-g1+scale_x_datetime(labels=date_format("%Y-%m-%d %H:%M:%S"),date_labels = "%a ", date_breaks = "1 day")
g1<-g1+xlab(".")+ylab("Global Active Power(kilowatts)")


g<-ggplot(data=subsetted,aes(x=subsetted$datetime,y=subsetted$Voltage))+geom_line()
g<-g+scale_x_datetime(labels=date_format("%Y-%m-%d %H:%M:%S"),date_labels = "%a ", date_breaks = "1 day")
g<-g+xlab(".")+ylab("Voltage")

g2<-ggplot(data=subsetted,aes(x=subsetted$datetime,y=subsetted$Global_reactive_power))+geom_line()
g2<-g2+scale_x_datetime(labels=date_format("%Y-%m-%d %H:%M:%S"),date_labels = "%a ", date_breaks = "1 day")
g2<-g2+xlab(".")+ylab("Global Reactive Power")

d<-subsetted[,c("Sub_metering_1","Sub_metering_2", "Sub_metering_3","Global_active_power" , "datetime")]
d <- melt(d, id.vars="datetime") #d is the reshaped matrix


g3<-ggplot(d, aes(x=datetime, y=value,col=variable))
g3<-g3+scale_x_datetime(labels=date_format("%Y-%m-%d %H:%M:%S"),date_labels = "%a ", date_breaks = "1 day")

dev.copy(png,'C:\\Users\\rpande35\\Desktop\\plot4.png',width = 480, height = 480)

grid.arrange(g1, g,g3, g2,nrow=2,ncol=2)

dev.off()

