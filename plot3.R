### plot3.R will recreate the first plot given by the instructors.
### Our overall goal here is simply to examine how household energy usage varies over a 
### 2-day period in February, 2007. Your task is to reconstruct the following plots below, 
### all of which were constructed using the base plotting system.

###--------------------------------------------
### Step 1 - Download the data and load it in R. 
###--------------------------------------------
#Create directory where extracted data will be stored
if(!file.exists("./data")){dir.create("./data")}

# Download data from server
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "exdata%2Fdata%2Fhousehold_power_consumption.zip")

#unzip data and store it in folder "data"
unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip", exdir="./data")

#read the txt file and store it in a variable called df.
df <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";")

###--------------------------------------------------------------------
### Step 2: Subset the df to only include "2007-02-01" and "2007-02-02"
###--------------------------------------------------------------------
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df_sub <- df[(df$Date == "2007-02-01" | df$Date == "2007-02-02"),]

###--------------------------------------------------
###Step 3: Prepare the variables that will be plotted
###--------------------------------------------------
#Convert Global_active_power from "chr" to "num"
df_sub$Sub_metering_1 <- as.numeric(df_sub$Sub_metering_1)
df_sub$Sub_metering_2 <- as.numeric(df_sub$Sub_metering_2)
df_sub$Sub_metering_3 <- as.numeric(df_sub$Sub_metering_3)

#Create a variable that contains both date and time of class "POSIXct"
df_sub$datetime <- as.POSIXct(paste(df_sub$Date, df_sub$Time))

###--------------------------------------------------
###Step 4: Plot the graph and store it as a png. file
###--------------------------------------------------

png(filename = "plot3.png", width = 480, height = 480, units = "px")
#Create an empty plot
plot(df_sub$datetime, df_sub$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
#Add each submetering data individually
points(df_sub$datetime, df_sub$Sub_metering_1, type="l", col = "black")
points(df_sub$datetime, df_sub$Sub_metering_2, type="l", col = "red")
points(df_sub$datetime, df_sub$Sub_metering_3, type="l", col = "blue")
#add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)
dev.off()
