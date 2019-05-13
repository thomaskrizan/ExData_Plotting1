library(lubridate)
library(readr)
library(dplyr)

#Read in data using readr package with semicolon delimiters and missing values equal to ?
dt <- read_delim(file = "household_power_consumption.txt",delim = ";",na = "?")
#Format Date column as dates using the lubridate package
dt$Date <- dmy(dt$Date)
#subset for dates between 2007-02-01 amd 2007-02-02
df <- dt[dt$Date %between% c("2007-02-01","2007-02-02"),]
#Combine Date and Time columns into new date-time column
df <- df %>% mutate( "date-time" = ymd_hms(paste(Date,Time,sep = " ")))
#Open png graphics device
png(filename = 'plot4.png')
#Set up the 2,2 Plotting grid
par(mfrow = c(2,2))
#add the plot for the top left
plot(x = df$`date-time`,y = df$Global_active_power,type = "n",xlab = '', ylab = '')
title(ylab = "Global Active Power (kilowatts)")
lines(x = df$`date-time`,y = df$Global_active_power)
#add the plot for the top right
plot(x = df$`date-time`,y = df$Voltage,type = "n",xlab = '', ylab = '')
title(xlab = "datetime",ylab = "Voltage")
lines(x = df$`date-time`,y = df$Voltage)
#add the plot in the bottom left
plot(x = df$`date-time`,y = df$Sub_metering_1,type = 'n', xlab = "", ylab = "Energy sub metering")
lines(x$`date-time`,y = df$Sub_metering_1)
lines(x$`date-time`,y = df$Sub_metering_2,col = 'red')
lines(x$`date-time`,y = df$Sub_metering_3,col = 'blue')
legend("topright",inset = 0.02,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty = 1,cex = 0.8,box.lty = 0,y.intersp = 0.8)
#add the plot in the bottom right
plot(x = df$`date-time`,y = df$Global_reactive_power,type = "n",xlab = '', ylab = '')
title(xlab = "datetime",ylab = "Global_reactive_power")
lines(x = df$`date-time`,y = df$Global_reactive_power)
#turn off the graphics device
dev.off()
