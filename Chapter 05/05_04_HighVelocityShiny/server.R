# remarks -----------------------------------------------------------------

# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data
# Using Shiny with High Velocity Data

#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# set up ------------------------------------------------------------------

library(shiny)
library(lubridate)


HighVelSimTxt <-
  "../../HighVelocitySimulation.txt" # set this to the pathname of the simulation data


# Server ------------------------------------------------------------------

shinyServer(function(input, output, session) {
  collectOneObservation <- reactiveFileReader(100, NULL, HighVelSimTxt, read.table)
  
oneSecondOfData <- function() {
  bunchaSlots <- data.frame(
    "count" = rep(NA, 100000),
    "date" = rep(NA, 100000),
    "random" = rep(NA, 100000),
    stringsAsFactors = FALSE
  )
  
  amountOfRunTime <- now() + seconds(1)
  basIDX <- 0
  
  while (amountOfRunTime > now()) {
    bunchaSlots[basIDX, ] <- read.table(HighVelSimTxt, colClasses = c("integer", "character", "numeric"))
    basIDX <- basIDX + 1
  }
  
  bunchaSlots <- bunchaSlots[ !is.na(bunchaSlots$count) , ]
  return(bunchaSlots)
}
  
  output$latestObservation <- renderTable(collectOneObservation())
  
  output$oneSecondOfObservations <- renderDataTable(oneSecondOfData())
  
  
  # when the session ends
  session$onSessionEnded(function() {
   # collect100Observations$suspend()
  })
  
})
