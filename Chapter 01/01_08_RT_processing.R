# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 

# an example of Real Time processing high velocity data
 
# Setup -------------------------------------------------------------------

# import necessary libraries
list.of.packages <- c("DBI","RSQLite", "rjson")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if ( length(new.packages) ) install.packages(new.packages)

# SQLite support
library(DBI)
library(RSQLite)
library(rjson)

mySQLiteDB <- dbConnect(RSQLite::SQLite(), "AcquisitionDB.SQLite")

# processing --------------------------------------------------------------

while (TRUE) {
   doThisSQL <- " SELECT avg(V3), max(V1) FROM 'Acquired Data' "

   dataRead <- dbGetQuery(mySQLiteDB, doThisSQL)

   JSON_representation <- toJSON( dataRead )

   write(JSON_representation, file = "meanOfV3.json")

   # doThisSQL <- " DELETE FROM 'Acquired Data' WHERE V3 < :maxRow "
   # myDBIResult <- dbSendQuery(mySQLiteDB, doThisSQL )
   # dbBind(myDBIResult, list( maxRow = dataRead[[2]] ) )
   # dbFetch(myDBIResult)
}
# Clean up ----------------------------------------------------------------

dbDisconnect(mySQLiteDB)
