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

png(file="plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))

with(hpc_subset, plot(DateTime, Global_active_power, type="l", xaxt = "n", xlab="", ylab="Global Active Power"))
axis.POSIXct(side=1, x=hpc_subset$DateTime, format="%a", labels = TRUE)

with(hpc_subset, plot(DateTime, Sub_metering_1, type="n", xaxt = "n", xlab="", ylab="Energy sub metering"))
with(hpc_subset, lines(DateTime, Sub_metering_1, col='black'))
with(hpc_subset, lines(DateTime, Sub_metering_2, col='red'))
with(hpc_subset, lines(DateTime, Sub_metering_3, col='blue'))
axis.POSIXct(side=1, x=hpc_subset$DateTime, format="%a", labels = TRUE)
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c('black','red','blue'), cex=0.95, bty="n")    

with(hpc_subset, plot(DateTime, Voltage, type="l", xaxt = "n", xlab="datetime", ylab="Voltage"))
axis.POSIXct(side=1, x=hpc_subset$DateTime, format="%a", labels = TRUE)

with(hpc_subset, plot(DateTime, Global_reactive_power, type="l", xaxt = "n", xlab="datetime", ylab="Global Reactive Power"))
axis.POSIXct(side=1, x=hpc_subset$DateTime, format="%a", labels = TRUE)

dev.off()