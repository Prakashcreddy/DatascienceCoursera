getwd()
str(household_power_consumption)

###Plot 1####
png("plot1.png", width=480, height=480)
hist(as.numeric(household_power_consumption$Global_active_power), breaks=10,
     xlab ="Global Active Power (Kilowatts)" ,main="Global Active Power", col="red")
dev.off()
###Plot 2####
subSetData <- household_power_consumption[household_power_consumption$Date %in% c("1/2/2007","2/2/2007") ,]
datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subSetData$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
###Plot 3####
subSetData <- household_power_consumption[household_power_consumption$Date %in% c("1/2/2007","2/2/2007") ,]
datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
Sub_metering_1 <- as.numeric(subSetData$Sub_metering_1)
Sub_metering_2<-as.numeric(subSetData$Sub_metering_2)
Sub_metering_3<-as.numeric(subSetData$Sub_metering_3)

###Plotting #####
png("plot3.png", width=480, height=480)
plot(datetime,Sub_metering_1, type="l", xlab="", ylab="Energy Sub Meeting")
lines(datetime, Sub_metering_2, type="l", col="red")
lines(datetime, Sub_metering_3,type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1.5, col=c("black", "red", "blue"))   
dev.off()

####Plot 4####
globalVoltage <- as.numeric(subSetData$Voltage)
globalreactivePower <- as.numeric(subSetData$Global_reactive_power)
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
##Part 1
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
###Part 2
plot(datetime, globalVoltage, type="l", xlab="", ylab="Voltage")
###Part 3
plot(datetime,Sub_metering_1, type="l", xlab="", ylab="Energy Sub Meeting")
lines(datetime, Sub_metering_2, type="l", col="red")
lines(datetime, Sub_metering_3,type="l", col="blue")
###Part 4
plot(datetime, globalreactivePower, type="l", xlab="", ylab="Global Reactive Power (kilowatts)")
dev.off()

