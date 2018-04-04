#load libraries
library(data.table)
library(dplyr)
library(ggplot2)
library(reshape2)

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

#drawing plot3

  #subsetting the four desired columns
d<-subsetted[,c("Sub_metering_1","Sub_metering_2", "Sub_metering_3","Global_active_power" , "datetime")]
  #convert it into tall format
d <- melt(d, id.vars="datetime")

dev.copy(png,'C:\\Users\\rpande35\\Desktop\\plot3.png',width = 480, height = 480)
  #drawing the plot
ggplot(d, aes(x=datetime,y=value, col=variable))+
  scale_x_datetime(labels=date_format("%Y-%m-%d %H:%M:%S"),date_labels = "%a ", date_breaks = "1 day")

dev.off()

 ##issue: columns of sub metrins have value as zero in all the column