library(dplyr)

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

## add the datetime variable by concatenating the Date and Time variable and
## convert to POSIXct data type
df <- mutate(df, datetime = as.POSIXct(paste(df$Date, df$Time)), .before=1)

## create the Global_active_power line graph without x-axis labels or tick marks
## add the x-axis labels and tick marks corresponding to the day of week abbreviation
png("plot2.png")
with(df, plot(datetime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n"))
axis.POSIXct(1, df$datetime, at=seq.Date(min(df$Date), by="day", length.out=3), format="%a")
dev.off()

