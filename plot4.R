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

#create plot4
plotdata<-read_data()

par(mfrow=c(2,2))
with(plotdata, {
        plot(Global_active_power~dateTime, type="l", ylab="Global Active Power", xlab="")
        plot(Voltage~dateTime, type="l", ylab="Voltage", xlab="datetime")
        plot(Sub_metering_1~dateTime, type="l", ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)
        plot(Global_reactive_power~dateTime, type="l", ylab="Global_reactive_power",xlab="datetime")
})

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
