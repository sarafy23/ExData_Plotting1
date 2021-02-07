
cons<-read.csv2("household_power_consumption.txt",stringsAsFactors = F,sep = ";", dec = ".")
head(cons, 10)

#subset for certain dates
cons2 <- cons[cons$Date %in% c("1/2/2007","2/2/2007") ,]
#can also do cons2<-subset(cons,cons$Date=="1/2/2007" | cons$Date =="2/2/2007")

class(cons2$Global_active_power) #currently a character vector
#convert character to numeric
activepower <- as.numeric(cons2$Global_active_power)

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


png("plot2.png")
plot(datetime2, activepower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off() 