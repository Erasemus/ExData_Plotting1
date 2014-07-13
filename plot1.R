## assumes data has beendownloaded and unzipped to ~/Downloads
##
##
## Get the header row
##
hr<-read.table( "~/Downloads/household_power_consumption.txt",nrows=1,sep=";",header=T)
##
## Get the data we want and set the column names 
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
## Plot Global Active Power Histogram
##
png(filename="~/Documents/plot1.png",height=480,width=480)
hist(hc$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts",col="red")
dev.off
