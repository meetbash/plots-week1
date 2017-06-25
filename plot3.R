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

#create plot3
plotdata<-read_data()

with(plotdata, {
        plot(Sub_metering_1~dateTime, type="l",ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = "solid", merge=TRUE, bg="white")

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
