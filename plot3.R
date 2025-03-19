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

png("plot3.png")
with(df, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", xaxt="n"))
with(df, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(df, lines(DateTime, Sub_metering_3, type="l", col="blue"))
axis.POSIXct(1, df$DateTime, at=seq.Date(min(df$Date), by="day", length.out=3), format="%a")
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), legend=names(df)[8:10])
dev.off()

