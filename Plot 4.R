## 1. read the household_power_consumption.txt file
## household_power_consumption.txt file located in the main working directory

data <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )

## Create a column in data with date and time merged 
FullDate <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
data <- cbind(data, FullDate)

## Correct the data class 
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- format(data$Time, format="%H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

### subset data date from 2007-02-01 to 2007-02-02
subsetdata <- subset(data, Date == "2007-02-01" | Date =="2007-02-02")

## generate 4 plots in 1 space (Global Active Power vs. time, Voltage vs. time, submetering vs. time and Gobal Reactive Power vs. time)

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(subsetdata, plot(FullDate, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(subsetdata, plot(FullDate, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(subsetdata, plot(FullDate, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(subsetdata$FullDate, subsetdata$Sub_metering_2,type="l", col= "red")
lines(subsetdata$FullDate, subsetdata$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(subsetdata, plot(FullDate, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()