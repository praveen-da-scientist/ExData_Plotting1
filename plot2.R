##*************************************************************************************************  
##Script Name: plot2.R
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
#     4. plot2.png will be created in the working directory. 
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

#Plot the Data
plotData$Global_active_power <- as.numeric(plotData$Global_active_power)
plot(plotData$Global_active_power ~  plotData$DateTime, 
     ylab="Global Active Power (kilowatts)", xlab= " ", type = "l") 

#copy the current plot to a PNG file and off the device
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()

#Batch script completed and hence cleaning up the objects
rm(plotData)

## End(Not run)
