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

##Creates plot and png 4
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2))

plot(datetime, subdata$Global_active_power, type = "l", xlab=" ", ylab="Global Active Power")
plot(datetime, subdata$Voltage, type="l", ylab="Voltage")

plot(datetime, subdata$Sub_metering_1,type="l", xlab="", ylab= "Energy sub metering")
lines(datetime, subdata$Sub_metering_2, type="l", col="red")
lines(datetime, subdata$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1, col=c("black", "red", "blue"))
plot(datetime, subdata$Global_reactive_power, type="l", ylab="Global_reactive_power")

dev.off()