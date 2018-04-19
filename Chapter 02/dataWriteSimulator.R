# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data

# A simulator to randomly write data to a file. Used for polling and interrupt demos
rowcounter <- 0

writeToHere <- "HighVelocitySimulation.txt"

for (limitRun in 1:200) {
  while (file.exists(writeToHere)) {} # wait until the last file is removed
  
  delayTillNextWrite <- as.integer(runif(n = 1, min = 1, max = 10))
  Sys.sleep(delayTillNextWrite)
  
  writeThisLine <- data.frame(rowcounter,
                              strftime(Sys.time()),
                              rnorm(1, mean = 128, sd = 2),
                              delayTillNextWrite)
  
  write.table(
    writeThisLine,
    file = writeToHere,
    append = FALSE,
    col.names = FALSE,
    row.names = FALSE
  )
  
  rowcounter <- rowcounter + 1
}
