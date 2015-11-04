#Create data directory, download and unzip file

if(!file.exists('./data')) {dir.create('./data')} #create a data dir if it doesn't exist
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, destfile='./data/Dataset.zip')  # Create zip file and download dataset
unzip(zipfile='./data/Dataset.zip', exdir='./data')    # unzip file

#Code for plot 4

library(dplyr)

#Read dataset into R
data <- read.table('./data/household_power_consumption.txt',sep=';', header=TRUE, stringsAsFactors=FALSE)

subSet <- filter(data, Date =='1/2/2007'| Date =='2/2/2007') #filter for correct dates
subSet[,3] <- as.numeric(subSet[,3]) # change Global_active_power to numeric variable
dateTime <- paste(subSet[,1], subSet[,2], sep=' ') #paste Date & Time
subSet$DateTime <- strptime(dateTime, '%d/%m/%Y %H:%M:%S')  # change format & add column to subSet
subSet[,7] <- as.numeric(subSet[,7]) ## Change Sub_metering variables to numeric
subSet[,8] <- as.numeric(subSet[,8])
subSet[,5] <- as.numeric(subSet[,5]) # change voltage to numeric variable

dev.copy(png, file='plot4.png', width=480, height=480) # width & height default set to 480
par(mfcol = c(2,2))

# top left
with(subSet, plot(DateTime, Global_active_power, type='l', ylab='Global Active Power', xlab=''))

#Bottom left
with(subSet, plot(DateTime, Sub_metering_1, type='l', ylab='Energy sub metering', xlab=''))
with(subset(subSet), lines(DateTime, Sub_metering_2, col='red'))
with(subset(subSet), lines(DateTime, Sub_metering_3, col='blue'))
legend('topright', lwd=1, col=c('black', 'red', 'blue'), legend= c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

##top right 
with(subSet, plot(DateTime, Voltage, type='l', ylab='Voltage', xlab='datetime'))

#bottom right
with(subSet, plot(DateTime, Global_reactive_power, type='l', xlab='datetime'))

dev.off()
