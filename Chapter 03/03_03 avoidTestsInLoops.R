
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
# install.packages("readr")
library(readr)
install.packages("lubridate")
library(lubridate)

# avoid tests in loops ---------------------------------------------------------

collectOneSecond <- function() {
  oneSecData <- data.frame("X1" = NA,
                           "X2" = NA,
                           "X3" = NA)
  
  amountOfRunTime <- now() + seconds(1)
  
  while (amountOfRunTime > now()) {
    newData <- read_delim(HighVelSimTxt, delim = " ", 
                          quote = '"', 
                          col_names = FALSE)
    oneSecData <- rbind(oneSecData, newData)
  }
  
  return(oneSecData)
}

noTestInLoopData <- collectOneSecond()

profvis(collectOneSecond_df())

