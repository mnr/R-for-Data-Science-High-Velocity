
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

# install.packages("data.table")
# install.packages("profvis")
# install.packages("lubridate")

library(data.table)
library(lubridate)
library(profvis)


# avoid tests in loops ---------------------------------------------------------

noTest_collectOneSecond <- function() {
  oneSecData <- data.frame("V1" = NA,
                           "V2" = NA,
                           "V3" = NA,
                           "V4" = NA)
  
  amountOfRunTime <- now() + seconds(1)
  
  while (amountOfRunTime > now()) {
    # substitute fread for read.table to remove tryCatch
    newData <- fread(HighVelSimTxt)
    
    # I'll address this test in the next video
    if (newData$V3 > 128 ) {
      newData$V4 <- "higher"
    } else {
      newData$V4 <- "lower"
    }
    
    oneSecData <- rbind(oneSecData, newData)
  }
  
  return(oneSecData)
}

noTestInLoopData <- noTest_collectOneSecond()

profvis(collectOneSecond())

