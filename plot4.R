# URL of the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# This create a folder named "data" in your current directory if it does not exist already.
if (!file.exists("data")){
    dir.create("data")
}

# Downloading the zip file into the data directory and decompressing it.
# This gives a warning in R but works fine in RStudio.
download.file(url, destfile="./data/zip_file.zip", mode="wb", method="wget")
unzip("./data/zip_file.zip", exdir="./data/powerData")

# Reading only the first couple rows of the file to get some info about the data.
dirData <- "./data/powerData/household_power_consumption.txt"
powerData <- read.table(dirData, header = T, sep = ";", nrows = 10) 
dataNames <- names(powerData)
dataFile <- file(dirData)
classes <- sapply(powerData, class)
# Reading only the data of the two days of interest.
# Note: Reading the subset of the data actually took more time than reading the whole data.
# Setting na.strings = "?" based on the information provided.
powerData <- read.table(text = grep("^[1,2]/2/2007", readLines(dataFile), value = T), 
                    na.strings = "?", sep = ";", colClasses = classes, col.names = dataNames) 

# Closing the connection opened the "file()" function.
close(dataFile)

# Converting the Date and Time variables to Date/Time classes and creating a new variable
# of the date and time combination.
# Plot seems to not like "POSIXlt" date format so converting to "POSIXct".
DateTime <- paste(as.Date(powerData$Date, "%d/%m/%Y"), powerData$Time)
powerData$DateTime <- as.POSIXct(strptime(DateTime, "%Y-%m-%d %H:%M:%S"))

# Plotting the Global Active Power, the Voltage, the different Sub Metering and the Global Reactive
# Power on the same graph in the format of 2x2 matrix.
# This will not work in RStudio - it produces the error: Error in plot.new() : figure margins too large. 
par(mfrow = c(2, 2))
with(powerData, {
    plot(powerData$Global_active_power ~ powerData$DateTime, type = "l", xlab = "", 
         ylab = "Global Active Power")
    plot(powerData$Voltage ~ powerData$DateTime, type = "l", xlab = "Datetime", ylab = "Voltage")
    plot(powerData$Sub_metering_1 ~ powerData$DateTime, col = "black", xlab = "", 
         ylab = "Energy Sub Metering", type = "l")
    lines(powerData$Sub_metering_2 ~ powerData$DateTime, col = "red")
    lines(powerData$Sub_metering_3 ~ powerData$DateTime, col = "blue")
    # Legend does not work properly in RStudio.
    legend("topright", legend = c("Sub Metering-1", "Sub Metering-2", "Sub Metering-3"),
           col = c("black", "red", "blue"), lty = 1, lwd = 1, bty = "n")
    plot(powerData$Global_reactive_power ~ powerData$DateTime, type = "l", xlab = "Datetime", ylab = "Global Reactive Power")
    
})

# Saving the result of the plot in PNG file.
dev.copy(png, file = "plot4.png", width = 480, height = 480) 
dev.off() 

# Closing all unused connections.
closeAllConnections()


