



# remarks -----------------------------------------------------------------

# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data


# setup -------------------------------------------------------------------
# start up the high velocity data simulator
HighVelSimTxt <-
  "../HighVelocitySimulation.txt" # set this to the pathname of the simulation data

library(lubridate)
library(Rcpp)

rcpp_collectOneSecond <- function() {
  oneSecData <- vector(mode = "list", 10000)
  dataIDX <- 1
  
  cppFunction(
    'String highlo(int comparVal) {
    if (comparVal > 128) { 
        return("higher"); 
    }
    else {
        return("lower");
    }
}'
)
  
  amountOfRunTime <- now() + seconds(1)
  
  while (amountOfRunTime > now()) {
    newData <- read.table(HighVelSimTxt)
    
    newData$V4 <- highlo(newData$V3) # replaces previous if...then
    
    oneSecData[[dataIDX]] <- newData
    dataIDX <- dataIDX + 1
    
  }
  
  # remove empty elements of oneSecondOfData
  allGoodData <- oneSecData[!sapply(oneSecData, is.null)]
  
  return(allGoodData)
  }

rcpp_oneSecondOfData <- rcpp_collectOneSecond()

profvis(rcpp_collectOneSecond())
