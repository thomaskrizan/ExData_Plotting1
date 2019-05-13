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
png(filename = 'plot2.png')
#Create the Plot
plot(x = df$`date-time`,y = df$Global_active_power,type = "n",xlab = '', ylab = '')
title(ylab = "Global Active Power (kilowatts)")
lines(x = df$`date-time`,y = df$Global_active_power)
#Close the graphics device
dev.off()
