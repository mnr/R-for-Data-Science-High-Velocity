
# remarks -----------------------------------------------------------------

# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 
# Faster R for high velocity data - optimizing for high velocity data


# setup -------------------------------------------------------------------
# start up the high velocity data simulator
HighVelSimTxt <- "../HighVelocitySimulation.txt" # set this to the pathname of the simulation data

library(lubridate)

# first attempt with no optimization ---------------------------------------------------------

nocopy_collectOneSecond <- function() {
  # oneSecData <- data.frame("V1" = NA,
  #                          "V2" = NA,
  #                          "V3" = NA,
  #                          "V4" = NA)
  oneSecData <- vector(mode = "list", 10000)
  dataIDX <- 1
  
  amountOfRunTime <- now() + seconds(1)
  
  while (amountOfRunTime > now()) {
    newData <-
      tryCatch(
        read.table(HighVelSimTxt),
        error = function(e)
          NULL
      )
    
    if (newData$V3 > 128 ) {
      newData$V4 <- "higher"
    } else {
      newData$V4 <- "lower"
    }
    
    # oneSecData <- rbind(oneSecData, newData)
    oneSecData[[dataIDX]] <- newData
    dataIDX <- dataIDX + 1
    
  }
  
  # remove empty elements of oneSecondOfData
  allGoodData <- oneSecData[!sapply(oneSecData, is.null)]
  
  return(allGoodData)
}

nocopy_oneSecondOfData <- nocopy_collectOneSecond()

profvis(nocopy_collectOneSecond())

