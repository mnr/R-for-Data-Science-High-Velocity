# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 

# SQL optimization

# Setup -------------------------------------------------------------------
library(DBI)
# library(RSQLite)
library(profvis)

sqliteDatabases <- datasetsDb()
dbReadTable(sqliteDatabases, "quakes")
mySQLiteDB <- dbConnect(RSQLite::SQLite(),"quakes")



# non-optimized -----------------------------------------------------------

do_this_sqlite <- "SELECT * FROM quakes"
loOptSQL <- function() {
  for (looping in 1:100) {
  dbTempData <- dbGetQuery(sqliteDatabases, do_this_sqlite)
  min(dbTempData$mag)
  max(dbTempData$mag)
  }
}

profvis(loOptSQL)


# smaller  ----------------------------------------------------------------
do_this_sqlite <- "SELECT * FROM quakes"
big_df <- dbGetQuery(sqliteDatabases, do_this_sqlite)


# You might want to explore SQLite views


