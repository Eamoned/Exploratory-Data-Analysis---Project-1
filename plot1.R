#Create data directory, download and unzip file

if(!file.exists('./data')) {dir.create('./data')} #create a data dir if it doesn't exist
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, destfile='./data/Dataset.zip')  # Create zip file and download dataset
unzip(zipfile='./data/Dataset.zip', exdir='./data')    # unzip file

#Code for plot 1

library(dplyr)

#Read dataset into R
data <- read.table('./data/household_power_consumption.txt',sep=';', header=TRUE, stringsAsFactors=FALSE)

subSet <- filter(data, Date =='1/2/2007'| Date =='2/2/2007') #filter for correct dates
subSet[,3] <- as.numeric(subSet[,3]) # change to numeric variable

#Construct Histogram
hist(subSet$Global_active_power, col='red', xlab='Global Active Power (kilowatts)', main='Global Active Power')
dev.copy(png, file='plot1.png',width=480, height=480) # width & height default set to 480
dev.off()
