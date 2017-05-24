library(dplyr)
library(lubridate)

hpc <- tbl_df(read.csv2(file="household_power_consumption.txt"))
hpc[hpc=="?"]<-NA
hpc$Date <- as.Date(hpc$Date, format = "%d / %m / %Y")
hpc_subset <- subset(hpc, Date == "2007-02-01" | Date == "2007-02-02")
hpc_subset <- mutate(hpc_subset,DateTime=paste(hpc_subset$Date, hpc_subset$Time))
#strptime(hpc_subset$DateTime,format="%Y-%m-%d %H:%M:%S")
hpc_subset$DateTime<-as.POSIXlt(hpc_subset$DateTime,format="%Y-%m-%d %H:%M:%S")

hpc_subset$Global_active_power   <- as.numeric(as.character(hpc_subset$Global_active_power))
hpc_subset$Global_reactive_power <- as.numeric(as.character(hpc_subset$Global_reactive_power))
hpc_subset$Voltage               <- as.numeric(as.character(hpc_subset$Voltage))
hpc_subset$Global_intensity      <- as.numeric(as.character(hpc_subset$Global_intensity))
hpc_subset$Sub_metering_1        <- as.numeric(as.character(hpc_subset$Sub_metering_1))
hpc_subset$Sub_metering_2        <- as.numeric(as.character(hpc_subset$Sub_metering_2))
hpc_subset$Sub_metering_3        <- as.numeric(as.character(hpc_subset$Sub_metering_3))

png(file="plot1.png", width = 480, height = 480)
hist(hpc_subset$Global_active_power, main="Global Active Power", col='red', xlab="Global Active Power (kilowatts)")
dev.off()