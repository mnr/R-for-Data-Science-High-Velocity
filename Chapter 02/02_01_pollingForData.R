# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data

# A demonstration of polling for data

HighVelSimTxt <- "../HighVelocitySimulation.txt" # set this to the pathname of the simulation data

while (TRUE) {
  if (file.exists(HighVelSimTxt)) {
    Sys.sleep(1) # give the simulator time to finish writing
    dataFromPolling <- read.table(HighVelSimTxt)
    print(dataFromPolling)
    file.remove(readFromHere)
  }
}
