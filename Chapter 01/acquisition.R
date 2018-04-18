# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 

# An example of real-time data acquisition

# Setup -------------------------------------------------------------------
HighVelSimTxt <- "HighVelocitySimulation.txt" # set this to the pathname of the simulation file

# import necessary libraries
list.of.packages <- c("DBI","RSQLite")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if ( length(new.packages) ) install.packages(new.packages)

# SQLite support
library(DBI)
library(RSQLite)

mySQLiteDB <- dbConnect(RSQLite::SQLite(), 
                        "AcquisitionDB.SQLite")

# Acquire --------------------------------------------------------------

highVelData <- file(HighVelSimTxt, "r")

while (TRUE) {
  newData <- tryCatch(
    read.table(HighVelSimTxt),
    error = function(e) NULL
  )
  
  if (length(newData) > 0) {
    dbWriteTable(mySQLiteDB,
                 name = "Acquired Data",
                 value = newData,
                 append = TRUE)
  }
  Sys.sleep(2) # because SQLite doesn't handle concurrency very well
  
}

# dbReadTable(mySQLiteDB, name="Acquired Data") # optional to check database contents

# Clean up ----------------------------------------------------------------

dbDisconnect(mySQLiteDB)
