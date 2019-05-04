# Reading, naming and subsetting power consumption data
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subs <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

subs$Date <- as.Date(subs$Date, format="%d/%m/%Y")
subs$Time <- strptime(subs$Time, format="%H:%M:%S")
subs[1:1440,"Time"] <- format(subs[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subs[1441:2880,"Time"] <- format(subs[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# calling the basic plot function
plot(subs$Time,as.numeric(as.character(subs$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)") 

# annotating graph
title(main="Global Active Power Vs Time")
