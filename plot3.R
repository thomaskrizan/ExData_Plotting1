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
png(filename = 'plot3.png')
#create the plot
plot(x = df$`date-time`,y = df$Sub_metering_1,type = 'n', xlab = "", ylab = "Energy sub metering")
lines(x$`date-time`,y = df$Sub_metering_1)
lines(x$`date-time`,y = df$Sub_metering_2,col = 'red')
lines(x$`date-time`,y = df$Sub_metering_3,col = 'blue')
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty = 1,cex = 0.8)
#Close the graphics device
dev.off()
