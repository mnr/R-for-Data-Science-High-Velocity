# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 

rowcounter <- 0

HSDtmpFile <- "tempSim.txt"
HSDFinalFile <- "HighVelocitySimulation.txt"

while (!file.exists(HSDFinalFile)) {
  writeThisLine <- data.frame(rowcounter,
                              strftime(Sys.time()),
                              rnorm(1, mean = 128, sd = 5))
  
  write.table(writeThisLine, 
              file = HSDtmpFile,
              append = FALSE,
              col.names = FALSE,
              row.names = FALSE)
  
  file.rename(from = HSDtmpFile, to = HSDFinalFile) 
  
  rowcounter <- rowcounter + 1
  
  Sys.sleep(runif(1, min = 0.1, max = 1.5))
  
}


