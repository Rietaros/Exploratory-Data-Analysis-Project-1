# Reading, naming and subsetting power consumption data
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subs <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

subs$Time <- strptime(subs$Time, format="%H:%M:%S")
subs$Date <- as.Date(subs$Date, format="%d/%m/%Y")

subs[1:1440,"Time"] <- format(subs[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subs[1441:2880,"Time"] <- format(subs[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# initiating a composite plot with many graphs
par(mfrow=c(2,2))

# calling the basic plot function that calls different plot functions to build the 4 plots that form the graph
with(subs,{
  plot(subs$Time,as.numeric(as.character(subs$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subs$Time,as.numeric(as.character(subs$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(subs$Time,subs$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subs,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subs,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subs,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(subs$Time,as.numeric(as.character(subs$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})