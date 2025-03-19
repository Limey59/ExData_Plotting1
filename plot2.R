library(dplyr)

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "exdata-data-household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"


if (!file.exists(zipFile))
    download.file(fileURL, zipFile, method="curl")

if (!file.exists(dataFile))
    unzip(zipFile)

df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
df$Date <- as.Date(strptime(df$Date,"%d/%m/%Y"))
df <- subset(df, Date >= "2007-02-01" & Date <= "2007-02-02")
df <- mutate(df, DateTime = as.POSIXct(paste(df$Date, df$Time)), .before=1)
df <- mutate(df, Weekday = weekdays(df$Date))

png("plot2.png")
with(df, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n"))
axis.POSIXct(1, df$DateTime, at=seq.Date(min(df$Date), by="day", length.out=3), format="%a")
dev.off()
