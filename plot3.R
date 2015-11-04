#Create data directory, download and unzip file

if(!file.exists('./data')) {dir.create('./data')} #create a data dir if it doesn't exist
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, destfile='./data/Dataset.zip')  # Create zip file and download dataset
unzip(zipfile='./data/Dataset.zip', exdir='./data')    # unzip file

#Code for plot 3

library(dplyr)

#Read dataset into R
data <- read.table('./data/household_power_consumption.txt',sep=';', header=TRUE, stringsAsFactors=FALSE)

subSet <- filter(data, Date =='1/2/2007'| Date =='2/2/2007') #filter for correct dates
dateTime <- paste(subSet[,1], subSet[,2], sep=' ') #paste Date & Time
subSet$DateTime <- strptime(dateTime, '%d/%m/%Y %H:%M:%S')  # change format & add column to subSet
with(subSet, plot(DateTime, Global_active_power, type='l', ylab='Global Active Power (Kilowatts)', xlab=''))
subSet[,7] <- as.numeric(subSet[,7]) ## Change Sub_metering variables to numeric
subSet[,8] <- as.numeric(subSet[,8])

dev.copy(png, file='plot3.png', width=480, height=480) # width & height default set to 480
with(subSet, plot(DateTime, Sub_metering_1, type='l', ylab='Energy sub metering', xlab=''))
with(subset(subSet), lines(DateTime, Sub_metering_2, col='red'))
with(subset(subSet), lines(DateTime, Sub_metering_3, col='blue'))
legend('topright', lwd=1, col=c('black', 'red', 'blue'), legend= c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()
