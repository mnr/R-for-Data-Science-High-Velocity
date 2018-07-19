
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
HighVelSimTxt <- "HighVelocitySimulation.txt" # set this to the pathname of the simulation data

library(lubridate)

# use ifelse instead of if...else ---------------------------------------------------------

ifElse_collectOneSecond <- function() {
  oneSecData <- data.frame("V1" = NA,
                           "V2" = NA,
                           "V3" = NA,
                           "V4" = NA)
  
  amountOfRunTime <- now() + seconds(1)
  
  while (amountOfRunTime > now()) {
    newData <- read.table(HighVelSimTxt)
    
    newData$V4 <- ifelse(newData$V3 > 128, "higher", "lower")

    oneSecData <- rbind(oneSecData, newData)
  }
  
  # it would be better to place this outside of the loop
  # newData$V4 <- ifelse(newData$V3 > 128,
  #                      "higher",
  #                      "lower")
  
  return(oneSecData)
}

ifelseData <- ifElse_collectOneSecond()

profvis(collectOneSecond_df())

