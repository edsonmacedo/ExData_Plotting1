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

#Plot 4
png(filename = "plot4.png")
par(mfrow = c(2,2))
#Plot 4.1
plot(EletricPowerConsumption$DateTime, EletricPowerConsumption$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "", xlim = c(dmy("01/02/2007"), max(EletricPowerConsumption$DateTime)))
#Plot 4.2
plot(EletricPowerConsumption$DateTime, EletricPowerConsumption$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", xlim = c(dmy("01/02/2007"), max(EletricPowerConsumption$DateTime)))
#Plot 4.3
GatheredEletric <- gather(data = EletricPowerConsumption, key = Sub_metering, value = Energy_sub_metering, Sub_metering_1:Sub_metering_3)
plot(GatheredEletric$DateTime, GatheredEletric$Energy_sub_metering, type = "n", xlab = "", ylab = "Energy sub metering", xlim = c(dmy("01/02/2007"), max(EletricPowerConsumption$DateTime)))
with(subset(GatheredEletric, Sub_metering == "Sub_metering_1"), lines(DateTime, Energy_sub_metering, col = "black"))
with(subset(GatheredEletric, Sub_metering == "Sub_metering_2"), lines(DateTime, Energy_sub_metering, col = "red"))
with(subset(GatheredEletric, Sub_metering == "Sub_metering_3"), lines(DateTime, Energy_sub_metering, col = "blue"))
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Plot 4.4
plot(EletricPowerConsumption$DateTime, EletricPowerConsumption$Global_active_power, type = "h", ylab = "Global_active_power", xlab = "datetime", xlim = c(dmy("01/02/2007"), max(EletricPowerConsumption$DateTime)))
dev.off()