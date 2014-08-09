##########################################################
#           Programming Assignment 1 - Plot 2            #
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
#                   Plot 2                    #
###############################################

# Subset the dates to the desired days
dates <- clean_dates[indexes]
# Save the power values to the variable
power_values <- data$Global_active_power


# Plot and save to file
plot(dates,power_values, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", width=480, height=480, units = "px")
dev.off()