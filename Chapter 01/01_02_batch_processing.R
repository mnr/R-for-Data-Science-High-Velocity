# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 

# an example of batch processing high velocity data

 
# Setup -------------------------------------------------------------------
library(lubridate)
HighVelSimTxt <- "HighVelocitySimulation.txt" # set this to the pathname of the simulation file

# Acquire -----------------------------------------------------------------
# grab one second worth of data

collectOneSecond <- function() {
  oneSecData <- data.frame("V1" = NA,
                                "V2" = NA,
                                "V3" = NA)
  
  amountOfRunTime <- now() + seconds(1)
  
  while (amountOfRunTime > now()) {
    newData <-
      tryCatch(
        read.table(HighVelSimTxt),
        error = function(e)
          NULL
      )
    oneSecData <- rbind(oneSecData, newData)
  }
  
  return(oneSecData)
}

oneSecondOfData <- collectOneSecond()

# Process -----------------------------------------------------------------


# Present -----------------------------------------------------------------


# Clean up ----------------------------------------------------------------



