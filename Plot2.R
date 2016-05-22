#Loads the required packages

library("lubridate")
library("dplyr")
library("readr")
library("tidyr")

#Import the data (assuming that the required txt file is already in working directory)

Full <- read_delim(file = "household_power_consumption.txt", delim = ";", na = "?",col_types = "ccnnnnnnn", col_names = TRUE, progress = TRUE)
Full <- mutate(Full, DateTime = dmy_hms(paste(Full$Date, Full$Time)))
Full <- select(Full, DateTime, everything(), -Date, -Time)
EletricPowerConsumption <- filter(Full, DateTime >= "2007-02-01" & DateTime < "2007-02-03")
rm(Full)

#Plot 2
png(filename = "plot2.png")
plot(EletricPowerConsumption$DateTime, EletricPowerConsumption$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xlim = c(dmy("01/02/2007"), max(EletricPowerConsumption$DateTime)))
dev.off()