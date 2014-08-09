##########################################################
#           Programming Assignment 1 - Plot 4            #
#            Course: Exploratory Data Analysis           #
#         https://www.coursera.org/course/exdata         #
#                    Manuel Mateus                       #
##########################################################

# Set the locale to english to display the days in english
Sys.setlocale("LC_TIME", "English")

###############################################
#           Load and Cleaning of data         #
###############################################

# Assign the type of data to the columns
columns <- c("character","character",rep("numeric",7))

# Load the data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses=columns, na.strings=c("?",".","NA"))

# Store the date and hours in each array
dates <- data[,1]
hours <- data[,2]

# Concatenate the strings
new_date <- paste0(dates," ",hours)

# Convert it to time
clean_dates <- strptime(new_date, format="%d/%m/%Y %H:%M:%S")

# Inferior limit - first day
inferior_limit <- strptime("2007-02-01 00:00:00", format="%Y-%m-%d %H:%M:%S")

# Superior limit - last day
superior_limit <- strptime("2007-02-03 00:00:00", format="%Y-%m-%d %H:%M:%S")

# The indexes of the data which belongs to these days
indexes <- which(clean_dates > inferior_limit & clean_dates < superior_limit)

# Subset the data to these days
data <- data[indexes,]


###############################################
#                   Plot 4                    #
###############################################

dates <- clean_dates[indexes]

par(mfrow = c(2,2))

# First Plot
power_values <- data$Global_active_power
plot(dates,power_values, type="l", ylab="Global Active Power",xlab="")

# Second Plot
voltage <- data$Voltage
plot(dates,voltage, type="l", ylab="Voltage", xlab="datetime")

# Third Plot
sub_metering_one <- data$Sub_metering_1
sub_metering_two <- data$Sub_metering_2
sub_metering_three <- data$Sub_metering_3
plot(dates,sub_metering_one, type="l", ylab="Energy sub metering", xlab="")
lines(dates,sub_metering_two, type="l", col="red")
lines(dates,sub_metering_three,type="l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"), bty='n', cex=.5)

# Fourth Plot
global_reactive_power <- data$Global_reactive_power
plot(dates,global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

# Save the plots to the png file
dev.copy(png, file="plot4.png", width=480, height=480, units = "px")
dev.off()