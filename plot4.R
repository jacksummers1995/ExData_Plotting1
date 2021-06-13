## --- Load packages
pacman::p_load(tidyverse)

## --- Load data
data <- data.table::fread('household_power_consumption.txt')

data <- data %>% 
  dplyr::na_if('?') %>% 
  dplyr::mutate(Date = lubridate::dmy(Date)) %>% 
  dplyr::filter(between(Date, as.Date('2007-02-01'), as.Date('2007-02-02')))

for (i in setdiff(names(data),c("Date","Time"))){
  data[[i]] <- data[[i]] %>% as.numeric()
}

data <- data %>% 
  dplyr::mutate(Time = paste(Date,Time) %>% strptime(format = "%Y-%m-%d %H:%M:%S"))

## --- Plot 4
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(data, {
  plot(x = data$Time, y = data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(x = data$Time, y = data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(x = data$Time, y = data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(x = data$Time, y = data$Sub_metering_2, type = "l", col = "red")
  lines(x = data$Time, y = data$Sub_metering_3, type = "l", col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(x = data$Time, y = data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()
