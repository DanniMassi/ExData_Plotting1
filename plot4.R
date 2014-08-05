#load libraries

#get full dataset
big_data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", 
                       nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
big_data$Date <- as.Date(big_data$Date, format = "%d/%m/%Y")

#subset to 2007 dates
subset2007 <- (big_data$Date >= "2007-02-01" & big_data$Date <= "2007-02-02")
data <- big_data[subset2007, ]

#remove big_data object
rm(big_data)

#combine date and time
dt <- paste(as.Date(data$Date), data$Time)
data$DateTime <- as.POSIXct(dt)

#make plot 4
par( mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0.5,0.5,2,0), cex=0.65)
with(data, {
            plot(data$Global_active_power~data$DateTime, type="l", col="black", ylab="Global Active Power", xlab="")
            plot(data$Voltage~data$DateTime, type="l", col="black", ylab="Voltage", xlab="datetime")
            plot(data$Sub_metering_1~data$DateTime, type="l", col="black", ylab="Energy sub metering", xlab="")
            lines(data$Sub_metering_2~data$DateTime, type="l", col="red")
            lines(data$Sub_metering_3~data$DateTime, type="l", col="blue")
            legend("topright", cex=0.6, col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
            plot(data$Global_reactive_power~data$DateTime, type="l", col="black", ylab="Global_reactive_power", xlab="datetime")
})


#write plot 4 to .png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
