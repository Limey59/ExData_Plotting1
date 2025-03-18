zipName <- "exdata-data-household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists(zipName))
    download.file(fileURL, zipName, method="curl")

if (!file.exists(dataFile))
    unzip(zipName)

df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
df$Date <- as.Date(strptime(df$Date,"%d/%m/%Y"))
df1 <- subset(df, Date >= "2007-02-01" & Date <= "2007-02-02")

png("plot1.png")
with(df1, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()