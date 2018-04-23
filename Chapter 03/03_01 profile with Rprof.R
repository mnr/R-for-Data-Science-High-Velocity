# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 

# learning about Rprof for profiling


# Setup -------------------------------------------------------------------
library(lubridate)
library(profvis)

HighVelSimTxt <- "HighVelocitySimulation.txt" # set this to the pathname of the simulation file
dummyData <- data.frame("V1" = NA,
                        "V2" = NA,
                        "V3" = NA)
write.table(dummyData, HighVelSimTxt)

writeToHere <- "HighVelocitySimulation2.txt" # set this to the pathname of the simulation file
writeThisLine <- data.frame(3,
              strftime(Sys.time()),
              rnorm(1, mean = 128, sd = 2),
              4)
write.table(
  writeThisLine,
  file = writeToHere,
  append = FALSE,
  col.names = FALSE,
  row.names = FALSE
)
# collectOneSecond with rbind and data frames acquire ------------------------------------------------------
collectOneSecond_df <- function() {
  oneSecData <- data.frame("V1" = NA,
                           "V2" = NA,
                           "V3" = NA)
  
  amountOfRunTime <- now() + seconds(1)
  
  while (amountOfRunTime > now()) {
    newData <-
      tryCatch(
        read.table(HighVelSimTxt),
        error = function(e)
          NULL
      )
    oneSecData <- rbind(oneSecData, newData)
  }
  
  return(oneSecData)
}




# Optimized collectOneSecond ----------------------------------------------

collectOneSecond_opt <- function() {
  #  oneSecData <- data.frame("V1" = NA, "V2" = NA, "V3" = NA)
  # pre-allocating a list is faster than copying each time through the loop
  oneSecData <- vector(mode = "list", 10000)
  
  amountOfRunTime <- now() + seconds(1)
  
  dataIDX <- 1
  
  while (amountOfRunTime > now()) {
    newData <-
      # tryCatch(
      #   read.table(HighVelSimTxt),
      #   error = function(e)
      #     NULL
      # )
      # scan returns a list instead of a data frame
      scan( file = writeToHere, 
            what = list( 0, "", "double" ),
            nmax = 1,
            fill = TRUE,
            quiet = TRUE
      )
    oneSecData[[dataIDX]] <- newData
    dataIDX <- dataIDX + 1
  }
  
  return(oneSecData)
}




# use profvis to generate profile graphs ----------------------------------
profvis(collectOneSecond_df())
profvis(collectOneSecond_opt())

# use Rprof to generate profiles ----------------------------------------------------------------------

Rprof("profileW_df") ; collectOneSecond_df() ; Rprof(NULL)
Rprof("profileWOUT_df") ; collectOneSecond_opt() ; Rprof(NULL)

# examine results of Rprof ---------------------------------------------------------

summaryRprof("profileW_df")
summaryRprof("profileWOUT_df")

