
## Download the household power consumption zip file - calling the file hpc.zip and unzipping the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "hpc.zip" , mode = "wb")
unzip("hpc.zip")

## reads the household_power_consumption.txt and removess missing values held by ? that is seperated by a semi colon
data <- read.table("household_power_consumption.txt", na.string=c("NA", "?"), header = TRUE, sep = ";")

## filters the dates and tidys the date for easy plotting
data$DateTime <- paste(data$Date, data$Time) 
data$DateTime <- as.Date(data$DateTime, format = "%d/%m/%Y %H:%M:%S")
library(dplyr)
subdata <- filter(data, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-03 00:00:00"))
datetime <- strptime(paste(subdata$Date, subdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

##Creates pdf file and png 2
png("plot2.png", width=480, height=480)

plot2.R = plot(datetime, subdata$Global_active_power, type="l", xlab="", ylab= "Global Active Power (killowatts)")

dev.off()
