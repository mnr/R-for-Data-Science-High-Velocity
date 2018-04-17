# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 

# an example of NRT processing high velocity data
 
# Setup -------------------------------------------------------------------
library(lubridate)
HighVelSimTxt <- "HighVelocitySimulation.txt" # set this to the pathname of the simulation file

cumulativeData <- data.frame("V1" = NA,
                             "V2" = NA,
                             "V3" = NA)

while (TRUE) {
  # Acquire -----------------------------------------------------------------
  # grab unprocessed data
  
  cumulativeData <- read.table(HighVelSimTxt)
  
  # Process -----------------------------------------------------------------
  # do something with the data
  meanResult <- mean(cumulativeData$V3, na.rm = TRUE)
  
  # Present -----------------------------------------------------------------
  flush.console()
  cat(sprintf("With %d observations, the mean of V3 is %.3f",
         nrow(cumulativeData),
         meanResult),
      "\r"
  )

}

