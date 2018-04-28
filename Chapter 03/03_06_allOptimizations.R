

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
HighVelSimTxt <-
  "../HighVelocitySimulation.txt" # set this to the pathname of the simulation data

library(data.table)
library(lubridate)
library(profvis)

# all optimizations ---------------------------------------------------------

allOpt_collectOneSecond <- function() {
  oneSecData <- vector(mode = "list", 10000)
  dataIDX <- 1
  amountOfRunTime <- now() + seconds(1)
  
  while (amountOfRunTime > now()) {
    newData <- fread(HighVelSimTxt)
    oneSecData[[dataIDX]] <- newData
    dataIDX <- dataIDX + 1
  }
  
  # remove empty elements of oneSecondOfData
  allGoodData <- oneSecData[!sapply(oneSecData, is.null)]
  
  # vectorize the creation of V4
  allGoodData <- lapply(allGoodData, 
                        function(x) { return(c(x$V1,
                                               x$V2,
                                               x$V3,
                                               ifelse(x$V3 > 128, "higher", "lower")))})
  
  return(allGoodData)
  
}

allOpt_oneSecondOfData <- allOpt_collectOneSecond()

profvis(allOpt_collectOneSecond())
