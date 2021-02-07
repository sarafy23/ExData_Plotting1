
cons<-read.csv2("household_power_consumption.txt",stringsAsFactors = F,sep = ";", dec = ".")
head(cons, 10)

#subset for certain dates
cons2 <- cons[cons$Date %in% c("1/2/2007","2/2/2007") ,]
#can also do cons2<-subset(cons,cons$Date=="1/2/2007" | cons$Date =="2/2/2007")

# Make a POSIXct date that can be filtered and graphed by time of day
class(cons2$Date) #it is currently a character
#convert Date variable from Character to Date format
cons2$Date <- as.Date(cons2$Date, format= "%d/%m/%Y")
#combine the two columns into a date&time variable
datetime <- paste(cons2$Date, cons2$Time, sep=" ")
class(datetime) #currently a character format
datetime2 <- as.POSIXct(datetime) #convert date&time variable to time class from character format 

#DATES are represented by the 'Date' class and are internally, stored as the number of days since 1970-01-01
#TIMES are represented by the 'POSIXct' and 'POSIXlt' classes.
#TIMES are internally stored as either the number of seconds since 1970-01-01 (for 'POSIXct') 
#or a list of seconds, minutes, hours, etc. (for 'POSIXlt').
#strptime() converts character vectors to POSIXlt. 


#convert character to numeric
activepower <- as.numeric(cons2$Global_active_power)

subMetering1 <- as.numeric(cons2$Sub_metering_1)
subMetering2 <- as.numeric(cons2$Sub_metering_2)
subMetering3 <- as.numeric(cons2$Sub_metering_3)

voltage <- as.numeric(cons2$Voltage)

reactive <-as.numeric(cons2$Global_reactive_power)

# make 2x2, filling rows first
par(mfrow=c(2,2))

#first argument will be subsetted dataset, then for each plot do y~x
with(cons2, {
        #active power first
        plot(activepower~datetime2, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        #voltage second
        plot(voltage~datetime2, type="l", xlab="datetime", ylab="Voltage", col="black")
        #energy sub-metering third
        plot(subMetering1~datetime2, type="l", xlab="", ylab="Energy Submetering", col="black")
        lines(subMetering2~datetime2, type="l", col="red")
        lines(subMetering3~datetime2, type="l", col="blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
        #reactive fourth
        plot(reactive~datetime2, type="l", xlab="datetime", ylab="Global_reactive_power", col="black")
})

dev.copy(png, file="plot4.png")

dev.off() 

