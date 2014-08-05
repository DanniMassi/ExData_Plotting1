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

#make plot 3
par(cex.lab=0.9, cex.axis=0.9, cex.main=0.9)
with(data, {
  plot(data$Sub_metering_1~data$DateTime, type="l", col="black", ylab="Energy sub metering", xlab="")
  lines(data$Sub_metering_2~data$DateTime, type="l", col="red")
  lines(data$Sub_metering_3~data$DateTime, type="l", col="blue")
})
legend("topright", lwd=2, lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pt.cex = 0.9)


#write plot 3 to .png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
