#read data and format it
read_data<-function(){
        alldata<-read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
        finalData <- alldata[alldata$Date %in% c("1/2/2007","2/2/2007"),]
        dateTime <-strptime(paste(finalData$Date, finalData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
        dateTime <- setNames(dateTime, "DateTime")
        finalData <- finalData[ ,!(names(finalData) %in% c("Date","Time"))]
        finalData <- cbind(dateTime, finalData)
        finalData$dateTime <- as.POSIXct(dateTime)
        finalData
}

#create plot1
plotdata<-read_data()
hist(plotdata$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
