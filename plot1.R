
cons<-read.csv2("household_power_consumption.txt",stringsAsFactors = F,sep = ";", dec = ".")
head(cons, 10)

#subset for certain dates
cons2 <- cons[cons$Date %in% c("1/2/2007","2/2/2007") ,]
#can also do cons2<-subset(cons,cons$Date=="1/2/2007" | cons$Date =="2/2/2007")

class(cons2$Global_active_power)
#convert character to numeric
activepower <- as.numeric(cons2$Global_active_power)

png("plot1.png")
hist(activepower, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
