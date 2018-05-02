# remarks -----------------------------------------------------------------

# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R Programming in Data Science: High Velocity Data
# openCPU


# set up ------------------------------------------------------------------

install.packages("opencpu")
library(opencpu)


# quick demo of OpenCPU -----------------------------------------------------------

available_apps()
ocpu_start_app("rwebapps/nabel")


# high velocity demo ------------------------------------------------------

HighVelocityOpenCPUDemo <- "mnr/R-for-Data-Science-High-Velocity/Chapter 04/04_05_OpenCPU/HighVelOpenCPU/"

install_apps(HighVelocityOpenCPUDemo)
ocpu_start_app(HighVelocityOpenCPUDemo)


# deploy ------------------------------------------------------------------

# https://www.opencpu.org/cloud
