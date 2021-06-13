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

## --- Plot 3
png(file = "plot3.png", width = 480, height = 480)

plot(x = data$Time,
     xlab = '',
     y = data$Sub_metering_1,
     ylab = 'Energy sub metering',
     type = 'l')
lines(x = data$Time,y = data$Sub_metering_2,type = 'l',col = 'red')
lines(x = data$Time,y = data$Sub_metering_3,type = 'l',col = 'blue')
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()