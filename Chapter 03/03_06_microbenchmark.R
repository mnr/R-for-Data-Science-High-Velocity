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

library(data.table)
# library(lubridate)
library(profvis)
library(ggplot2)
library(microbenchmark)


# starting script ---------------------------------------------------------
collectOneSecond <- function() {
  oneSecData <- data.frame(
    "V1" = NA,
    "V2" = NA,
    "V3" = NA,
    "V4" = NA
  )
  
  # amountOfRunTime <- now() + seconds(1)
  
  # while (amountOfRunTime > now()) {
  for (i in 1:100) {
    
    newData <- read.table(HighVelSimTxt)
    
    if (newData$V3 > 128) {
      newData$V4 <- "higher"
    } else {
      newData$V4 <- "lower"
    }
    
    oneSecData <- rbind(oneSecData, newData)
  }
  
  return(oneSecData)
}
# if else -----------------------------------------------------------------
ifElse_collectOneSecond <- function() {
  oneSecData <- data.frame("V1" = NA,
                           "V2" = NA,
                           "V3" = NA,
                           "V4" = NA)
  
  # amountOfRunTime <- now() + seconds(1)
  
  # while (amountOfRunTime > now()) {
  for (i in 1:100) {
    
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
# avoid copying data ------------------------------------------------------
nocopy_collectOneSecond <- function() {
  oneSecData <- vector(mode = "list", 10000)
  dataIDX <- 1
  
  # amountOfRunTime <- now() + seconds(1)
  
  # while (amountOfRunTime > now()) {
  for (i in 1:100) {
    
    newData <- read.table(HighVelSimTxt)
    
    if (newData$V3 > 128 ) {
      newData$V4 <- "higher"
    } else {
      newData$V4 <- "lower"
    }
    
    # oneSecData <- rbind(oneSecData, newData)
    oneSecData[[dataIDX]] <- newData
    dataIDX <- dataIDX + 1
    
  }
  
  # remove empty elements of oneSecondOfData
  allGoodData <- oneSecData[!sapply(oneSecData, is.null)]
  
  return(allGoodData)
}
# all optimizations -------------------------------------------------------
allOpt_collectOneSecond <- function() {
  oneSecData <- vector(mode = "list", 10000)
  dataIDX <- 1
  # amountOfRunTime <- now() + seconds(1)
  
  # while (amountOfRunTime > now()) {
  for (i in 1:100) {
    
    
    newData <- read.table(HighVelSimTxt)
    
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

# Run the benchmark -------------------------------------------------------

benchmarkresults <- microbenchmark(
  original = collectOneSecond(),
  ifElse = ifElse_collectOneSecond(),
  nocopy = nocopy_collectOneSecond(),
  allOptimizations = allOpt_collectOneSecond()
)

print(benchmarkresults)
boxplot(benchmarkresults)
autoplot(benchmarkresults)

