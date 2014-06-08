# obtain data
fileNameCleanDates <- "household_power_consumption.csv"
if (!file.exists(fileNameCleanDates)) {
   fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
   fileNameZipped <- "household_power_consumption.zip" 
   fileNameUnzipped <- "household_power_consumption.txt"
   
   if (!file.exists(fileNameZipped)) { 
      print("downloading dataset...")
      download.file(fileUrl, destfile = fileNameZipped, method = "curl") 
   }
   
   if (!file.exists(fileNameUnzipped)) { 
      print("unzipping dataset...")
      unzip(fileNameZipped)
   }
   
   # filter on date range
   household.power.consumption <- read.csv(fileNameUnzipped, sep=";", header=TRUE)
   household.power.consumption$Date <- as.Date(as.character(household.power.consumption$Date), "%d/%m/%Y")
   household.power.consumption <- subset(household.power.consumption, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
   
   write.csv(household.power.consumption, file=fileNameCleanDates)
} else {
   household.power.consumption <- read.csv(fileNameCleanDates, header=TRUE)   
}

sapply(household.power.consumption,class)
household.power.consumption <- transform(household.power.consumption, Timestamp=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

with(household.power.consumption, {
   plot(Timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power")
   plot(Timestamp, Voltage, type="l", xlab="datetime", ylab="Voltage")
   plot(Timestamp, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
   lines(Timestamp, Sub_metering_1, col="black")
   lines(Timestamp, Sub_metering_2, col="red")
   lines(Timestamp, Sub_metering_3, col="blue")
   legend("topright", bty="n", lty=1, lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
   plot(Timestamp, Global_reactive_power, type="l", xlab="datetime")
   
   
})

dev.off()