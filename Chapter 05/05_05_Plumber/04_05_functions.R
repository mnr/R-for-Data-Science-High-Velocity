
# remarks -----------------------------------------------------------------

# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data

# setup -------------------------------------------------------------------
# start up the high velocity data simulator
HighVelSimTxt <- "../../HighVelocitySimulation.txt" # set this to the pathname of the simulation data

library(lubridate)

#* @get /collectOneSecond
collectOneSecond <- function() {
  oneSecData <- vector(mode = "list", 10000)
  dataIDX <- 1

  amountOfRunTime <- now() + seconds(1)

  while (amountOfRunTime > now()) {
    newData <- read.table(HighVelSimTxt)

    if (newData$V3 > 128 ) {
      newData$V4 <- "higher"
    } else {
      newData$V4 <- "lower"
    }

    oneSecData[[dataIDX]] <- newData
    dataIDX <- dataIDX + 1

  }

  # remove empty elements of oneSecondOfData
  allGoodData <- oneSecData[!sapply(oneSecData, is.null)]

  return(allGoodData)
}


# get one read ------------------------------------------------------------

#* @get /collectOneRead
collectOneSecond <- function() {
  newData <- read.table(HighVelSimTxt)

  return(newData)
}

