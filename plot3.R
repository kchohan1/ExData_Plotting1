# PLOT 3
      
      packages <- c("data.table", "dplyr","lubridate")
      sapply(packages, require, character.only=TRUE, quietly=TRUE)
      
    # Download to current working directory and read data 
      
      fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileUrl,"./DataFiles", method="curl")
      unzip("./DataFiles")
      list.files()
      dateDownloaded <- date()
      dateDownloaded <- paste("Data was downloaded:", dateDownloaded[1])
      dateDownloaded
      
      dat <- data.table::fread("./household_power_consumption.txt", 
                               na.strings=c("?"), stringsAsFactors = FALSE)
      
    # Convert date/time variables to date/time formats
      dat$Time <- lubridate::dmy_hms(apply(dat[,1:2], 1, paste, collapse=" "))
      dat$Date<- as.Date(dat$Date, format = "%d/%m/%Y")
      str(dat)
      
    # Filter for relevant dates
      dat <- dplyr::filter(dat, Date %in% 
                             as.Date(c("1/2/2007", "2/2/2007"),"%d/%m/%Y")) 
      
    # Create plot 3
      dev.off()
      dev.cur()
      png(filename="plot3.png", width=480, height=480)
      par(mfcol=c(1,1), mar=c(5,4,4,2), bg=NA)
      plot(dat$Time, dat$Sub_metering_1, 
           xlab="", 
           ylab="Energy sub metering", 
           pch =".",
           type="l",
           col = "black")
      points(dat$Time,dat$Sub_metering_2, col="red", type="l")
      points(dat$Time,dat$Sub_metering_3, col="blue", type="l")
      legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1),lwd=c(1,1,1), cex=0.95,
             inset=0.00, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))      
      dev.off() # close the png device
