#Plot 2 Script
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

#makes Plot 2 png file

png(file="plot2.png", width=480, height=480)
with(myEPCdata_trimmed, plot(Date_and_Time,Global_active_power, type="l", xlab="",
                             ylab="Global Active Power (kilowatts)"))
dev.off()