##
## assumes data has been downloaded and unzipped to ~/Downloads
##
##
## Get the header row
##
hr<-read.table( "~/Downloads/household_power_consumption.txt",nrows=1,sep=";",header=T)
##
## Get the data we want
##
hc <- read.table(pipe('grep  "^[1-2]/2/2007" ~/Downloads/household_power_consumption.txt'),
                 sep=';',col.names=colnames(hr))
##
## make a Date
##
hc$Date<-as.Date(hc$Date,format="%d/%m/%Y")
##
## make sure we have just the data for the 1st and 2nd
##
x<-grep("02-0[1-2]",hc[,1])
hc<-hc[x,]
##
## make the other columns numeric 
##
for (col in 3:9) {(hc[,col]<-as.numeric(hc[,col]))}
##
## merge the date and time into a new column then get its POSIXct form 
##
hc$DateTime<-paste(hc$Date,hc$Time)
hc$DateTime<-strptime(hc$DateTime,"%Y-%m-%d %H:%M:%S")
dt<-as.POSIXct(hc$DateTime)
##
##Plot Global Active Power
##
png(filename="~/Documents/plot2.png",height=480,width=480)
plot(dt,hc$Global_active_power,t="l",ylab="Global Active Power (kilowatts)",xlab='')
dev.off