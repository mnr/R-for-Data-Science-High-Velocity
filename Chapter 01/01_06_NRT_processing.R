# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 

# an example of NRT processing high velocity data
 
# Setup -------------------------------------------------------------------
library(DBI)
library(RSQLite)

mySQLiteDB <- dbConnect(RSQLite::SQLite(), 
                        "AcquisitionDB.SQLite",
                        flags = SQLITE_RO)

# Process -----------------------------------------------------------------
doThisSQL <- " SELECT avg(V3), count(*) FROM 'Acquired Data' "

while (TRUE) {
  dataRead <- dbGetQuery(mySQLiteDB, doThisSQL)
  
  # Present -----------------------------------------------------------------
  flush.console()
  cat(sprintf("With %d observations, the mean of V3 is %.3f",
              dataRead$`count(*)`,
         dataRead$`avg(V3)`),
      "\r"
  )
  Sys.sleep(3) # because SQLite doesn't handle concurrency very well

}

# Clean up ----------------------------------------------------------------

dbDisconnect(mySQLiteDB)

