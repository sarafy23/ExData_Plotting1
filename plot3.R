
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

#Energy sub_metering
#turn from character to numeric
subMetering1 <- as.numeric(cons2$Sub_metering_1)
subMetering2 <- as.numeric(cons2$Sub_metering_2)
subMetering3 <- as.numeric(cons2$Sub_metering_3)

png("plot3.png")
plot(datetime2, subMetering1, type="l", xlab="", ylab="Energy Submetering", col="black")
lines(datetime2, subMetering2, type="l", col="red")
lines(datetime2, subMetering3, type="l", col="blue")
#lty=1 makes it so that you also have the colored lines in the legend, and not only the text
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

dev.off() 


