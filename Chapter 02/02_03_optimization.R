# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data

# Optimizing 01_02

# Setup -------------------------------------------------------------------
library(lubridate)
HighVelSimTxt <- "HighVelocitySimulation.txt" # set this to the pathname of the simulation file

# Acquire -----------------------------------------------------------------
# grab one second worth of data

collectOneSecond <- function() {
  # pre-allocating a list is faster than copying each time through the loop
  oneSecData <- vector(mode = "list", 10000)
  
  amountOfRunTime <- now() + seconds(1)
  
  dataIDX <- 1
  
  while (amountOfRunTime > now()) {
    newData <-
      # scan returns a list instead of a data frame
      scan( file = HighVelSimTxt, 
            what = list( 0, "", "double" ),
            nmax = 1,
            fill = TRUE,
            quiet = TRUE
            )
    oneSecData[[dataIDX]] <- newData
    dataIDX <- dataIDX + 1
  }
  
  # remove empty elements of oneSecondOfData
  allGoodData <- oneSecData[!sapply(oneSecData, is.null)]
  
  return(allGoodData)
}

allGoodData <- collectOneSecond()

# remove empty elements of oneSecondOfData
allGoodData_df <- data.frame(matrix(unlist(allGoodData), ncol = 3, byrow = TRUE),
                             stringsAsFactors = FALSE)

# Process -----------------------------------------------------------------
# do something with the data
meanResult <- mean(as.numeric(allGoodData_df$X3), na.rm = TRUE)

# Present -----------------------------------------------------------------
print(paste("The Arithmetic Mean of V3 is ", meanResult))



