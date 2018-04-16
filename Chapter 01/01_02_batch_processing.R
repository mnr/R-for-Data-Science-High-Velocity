# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data 

# an example of batch processing high velocity data


# Setup -------------------------------------------------------------------
setupForWindows <- function() {
  file.copy("sample_iostat.txt", "iostat.txt")
}

setupForMacUnix <- function() {
  system("iostat -c 2000 > iostat.txt", wait = FALSE)
}

switch(.Platform$OS.type,
        "unix" = setupForMacUnix(),
        "win" = setupForWindows()
        )
        

# Acquire -----------------------------------------------------------------


# Process -----------------------------------------------------------------


# Present -----------------------------------------------------------------


# Clean up ----------------------------------------------------------------



