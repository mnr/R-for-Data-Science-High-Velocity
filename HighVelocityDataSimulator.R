# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 

# A program that simulates high velocity data
# 1) change working directory to Chapter 01 of your exercise folder
# 2) start this program with "rscript 01_02_batch_HighVelocityDataSimulator.R"

rowcounter <- 0

HSDtmpFile <- "tempSim.txt"
HSDFinalFile <- "HighVelocitySimulation.txt"

RunningOnWindows <- startsWith(version$os,"ming") # TRUE if OS is windows
  
while (TRUE) {
  writeThisLine <- data.frame(rowcounter,
                              strftime(Sys.time()),
                              rnorm(1, mean = 128, sd = 5))
  
  write.table(writeThisLine, 
              file = HSDtmpFile,
              append = FALSE,
              col.names = FALSE,
              row.names = FALSE)
  
  if (RunningOnWindows) file.remove(HSDFinalFile)
  
  file.rename(from = HSDtmpFile, to = HSDFinalFile) 
  
  rowcounter <- rowcounter + 1
  
}


