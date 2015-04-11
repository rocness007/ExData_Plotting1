#Plot 4 Script
#load data, assumes the working directory has the unzipped folder acquired from Coursera

myEPCdata <- read.csv2("exdata_data_household_power_consumption/household_power_consumption.txt", na.strings="?", stringsAsFactors=F)
str(myEPCdata)

#change the date variable to date
myEPCdata <- transform(myEPCdata, Date = as.Date(Date, format="%d/%m/%Y"))

#narrow the dataset to only include 2007-02-01 and 2007-02-01
myEPCdata_trimmed <- subset(myEPCdata, Date == "2007-02-01" | Date == "2007-02-02")

#removes the large file, no longer needed
rm(myEPCdata)

#create a new varialbe that pastes the data and time together and then convert to date
myEPCdata_trimmed$Date_and_Time <- paste(myEPCdata_trimmed$Date, myEPCdata_trimmed$Time)
myEPCdata_trimmed$Date_and_Time <- strptime(myEPCdata_trimmed$Date_and_Time, "%Y-%m-%d %H:%M:%S")

#convert variables to numeric
myEPCdata_trimmed <- transform(myEPCdata_trimmed, Global_active_power = as.numeric(Global_active_power), 
                               Global_reactive_power = as.numeric(Global_reactive_power),
                               Voltage = as.numeric(Voltage), Global_intensity = as.numeric(Global_intensity))

#makes Plot 4 png file

png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(myEPCdata_trimmed, plot(Date_and_Time,Global_active_power, type="l", xlab="",
                             ylab="Global Active Power"))
with(myEPCdata_trimmed, plot(Date_and_Time, Voltage, type="l", xlab="datatime"))

with(myEPCdata_trimmed, plot(Date_and_Time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(myEPCdata_trimmed$Date_and_Time,myEPCdata_trimmed$Sub_metering_2, type="l", col="red")
lines(myEPCdata_trimmed$Date_and_Time,myEPCdata_trimmed$Sub_metering_3, type="l", col = "blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") ,lty=1, col=c("black", "red", "blue"),
       bty="n")

plot(myEPCdata_trimmed$Date_and_Time, myEPCdata_trimmed$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Globabl_reactive_power")
dev.off()