##*************************************************************************************************  
##Script Name: plot4.R
##*************************************************************************************************  
##OBJECTIVE:
##-------------------------------------------------------------------------------------------------
#  The objective of this R Script is to create the Plot as required by 
#  "Exploratory Data Analysis" Course Project 1. The dataset for this script should be downloaded 
#  from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#  The steps for executing the scripts are given below
#     1. Download the data set from the URL mentioned in the Dataset section.
#     2. Place the zip file in the same path as this script
#     3. Execute this script
#     4. plot4.png will be created in the working directory. 
##*************************************************************************************************  
##DATASET:
##-------------------------------------------------------------------------------------------------
#  The data set for this project was downloaded from the below URL
#     URL: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip  
##*************************************************************************************************  
##DEPENDENCIES:
##-------------------------------------------------------------------------------------------------
#  Following are the dependencies to execute this script successfully to create the tidy dataset   
#     1. The script except the dataset mentioned above to be downloaded and uncompressed in the  
#        relative path ./exdata-data-household_power_consumption
#     2. The script assumes that the following packages are installed and already loaded in the env
#        a. lubridate
#        
##*************************************************************************************************  
##MODIFICATION LOG:
##-------------------------------------------------------------------------------------------------
#  VER                          AUTHOR                DATE            REMARKS
#..................................................................................................
#  1.0                          PDASCIENTIST          11/08/15        INITIAL VERSION
#**************************************************************************************************  
#Load the dependent libraries
library(lubridate)

#Unzip the file which is placed in the working directory
unzip("exdata-data-household_power_consumption.zip")

#Read the Data to the variable masterData and convert the date and time columns
masterData <- read.table ("./household_power_consumption.txt", header = TRUE, sep = ";", 
                          stringsAsFactors=FALSE)
masterData$DateTime <- paste (masterData$Date,masterData$Time)

masterData$Date <- dmy(masterData$Date)
masterData$Time <- hms(masterData$Time)
masterData$DateTime <- dmy_hms(masterData$DateTime)

#Subset the plot data from masterData for 02/01/2007 and 02/02/2007
plotData <- subset(masterData, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

#Remove masterData to free up the memory
rm(masterData)

#Plot the Data to the PNG device after converting the columns to numeric
plotData$Sub_metering_1 <- as.numeric(plotData$Sub_metering_1)
plotData$Sub_metering_2 <- as.numeric(plotData$Sub_metering_2)
plotData$Sub_metering_3 <- as.numeric(plotData$Sub_metering_3)
plotData$Global_active_power <- as.numeric(plotData$Global_active_power)
plotData$Voltage <- as.numeric(plotData$Voltage)
plotData$Global_reactive_power <- as.numeric(plotData$Global_reactive_power)

#windows(480,480)

#Plot the Data to the PNG device after converting the columns to numeric
png(filename ="plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfcol = c(2,2), mar = c(4,4,2,2), oma = c(2,2,2,2))

# Plot the first chart
plot(plotData$Global_active_power ~  plotData$DateTime, 
     ylab="Global Active Power (kilowatts)", xlab= " ", type = "l") 

# Plot the second chart
plot(plotData$Sub_metering_1 ~  plotData$DateTime, 
     ylab="Energy sub metering", xlab= " ", type = "l" ) 
lines(plotData$Sub_metering_2 ~  plotData$DateTime, col="red")
lines(plotData$Sub_metering_3 ~  plotData$DateTime, col="blue")
legend("topright", col = c("black", "red", "blue"), lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8,
       box.col = par("bg"), inset = 0.05)

# Plot the third chart
plot(plotData$Voltage ~  plotData$DateTime, 
     ylab="Voltage", xlab= "datetime", type = "l" ) 

# Plot the fourth chart
plot(plotData$Global_reactive_power ~  plotData$DateTime, 
     ylab="Global_reactive_power", xlab= "datetime", type = "s" ) 

#Off the device
dev.off()

#Batch script completed and hence cleaning up the objects
rm(plotData)

## End(Not run)
