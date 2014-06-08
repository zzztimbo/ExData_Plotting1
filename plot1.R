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

png(filename = "plot1.png", width = 480, height = 480)
    
# histogram; change color, add labels for x axis and add title
hist(household.power.consumption$Global_active_power, col = "red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()

