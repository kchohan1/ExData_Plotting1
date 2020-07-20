# PLOT 1
    
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
      str(dat)
      
    # Create plot 1
      dev.off()
      dev.cur()
      png(filename="plot1.png", width=480, height=480)
      par(mfcol=c(1,1), mar=c(5,4,4,2), bg=NA)
      hist(dat$Global_active_power, col="red", 
                                    xlab = "Global Active Power (kilowatts)",
                                    main="Global Active Power",
                                    ylim = c(0,1200))
      
      dev.off() # close the png device
     