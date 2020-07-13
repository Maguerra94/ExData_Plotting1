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

## plot globalactivepower vs date&time
##dev.set
dev.set(which=2)
png("plot2.png", width=480, height=480)
with(subsetdata, plot(FullDate, Global_active_power, type="l", xlab="Day", ylab="Global Active Power (kilowatts)"))
dev.off()