# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 

# learning about Rprof for profiling


# Setup -------------------------------------------------------------------
# install.packages("tidyverse")
library(tidyverse) # if you haven't already
# install.packages("microbenchmark")
library(microbenchmark)

# setwd to chapter 03

# start data simulator ----------------------------------------------------
# start HighVelocitySimulator.R in separate R instance

HighVelSimTxt <- "../HighVelocitySimulation.txt" # set this to the pathname of the simulation file

numberOfIterations <- 1000

# collectOneThousand with rbind and data frames acquire ------------------------------------------------------
collectOneThousand_df <- function() {
  oneSecData <- data.frame("V1" = NA,
                           "V2" = NA,
                           "V3" = NA)
  
  # how it used to work ...
  # amountOfRunTime <- now() + seconds(1)
  
  # while (amountOfRunTime > now()) {
  
  # modified for microbenchmark
  for(counter in 1:numberOfIterations) {
    newData <- read.table(HighVelSimTxt)
    oneSecData <- rbind(oneSecData, newData)
  }
  
  return(oneSecData)
}

NonOptimizedResults <- collectOneThousand_df()

# Optimized collectOneSecond ----------------------------------------------

collectOneThousand_opt <- function() {
  #  oneSecData <- data.frame("V1" = NA, "V2" = NA, "V3" = NA)
  # pre-allocating a list is faster than copying each time through the loop
  oneSecData <- vector(mode = "list", 2000)
  
  # amountOfRunTime <- now() + seconds(1)
  
  # dataIDX <- 1
  
  # while (amountOfRunTime > now()) {
  for(counter in 1:numberOfIterations) {
    newData <- read.table(HighVelSimTxt)
    oneSecData[[counter]] <- newData
    # dataIDX <- dataIDX + 1
  }
  allGoodData <- oneSecData[!sapply(oneSecData, is.null)]
  
  return(allGoodData)
}

optimizedResults <- collectOneThousand_opt()

# Compare # of observations in optimizedResults vs NonOptimizedResults

# use microbenchmark  ----------------------------------------------------------------------
benchmarkresults <- microbenchmark(
  original = collectOneThousand_df(),
  optimized = collectOneThousand_opt()
)

print(benchmarkresults)
boxplot(benchmarkresults)
autoplot(benchmarkresults)
