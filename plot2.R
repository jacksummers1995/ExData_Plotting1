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

## --- Plot 2
png(file = "plot2.png", width = 480, height = 480)

plot(x = data$Time,
     xlab = '',
     y = data$Global_active_power,
     ylab = 'Global Active Power (Kilowatts)',
     type = 'l')

dev.off()