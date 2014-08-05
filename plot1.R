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

#make plot 1
par(cex.lab=0.9, cex.axis=0.9, cex.main=0.9)
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", col="red")

#write plot 1 to .png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
