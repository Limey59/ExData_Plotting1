## set fileURL and filename constants
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "exdata-data-household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"

## download the zip file if not already in the working directory
if (!file.exists(zipFile))
    download.file(fileURL, zipFile, method="curl")

## extract the data file from the zip if not already in the working directory
if (!file.exists(dataFile))
    unzip(zipFile)

## read the data into data frame, convert the Date variable to Date type and 
## filter to the relevant dates
df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
df$Date <- as.Date(strptime(df$Date,"%d/%m/%Y"))
df <- subset(df, Date >= "2007-02-01" & Date <= "2007-02-02")

## create the Global_active_power line graph in plot1 PNG file
png("plot1.png")
with(df, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()