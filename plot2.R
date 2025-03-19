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

png("plot1.png")
with(df, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()