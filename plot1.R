library(lubridate)
library(readr)
library(dplyr)

#Read in data using readr package with semicolon delimiters and missing values equal to ?
dt <- read_delim(file = "household_power_consumption.txt",delim = ";",na = "?")
#Format Date column as dates using the lubridate package
dt$Date <- dmy(dt$Date)
#subset for dates between 2007-02-01 amd 2007-02-02
df <- dt[dt$Date %between% c("2007-02-01","2007-02-02"),]
#Open png graphics device
png(filename = 'plot1.png')
#Create the histogram for plot 1
hist(x = df$Global_active_power,col = "red", ylim = c(0,1200), main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
#Close the graphics device
dev.off()
