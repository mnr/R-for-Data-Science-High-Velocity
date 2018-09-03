# Set Up ------------------------------------------------------------------

install.packages("plumber")
library(plumber)


# Collect One Second of Data ----------------------------------------------

# check your working directory so that 05_05_functions.R::collectOneSecond can be found
api <- plumb("05_05_functions.R")
api$run(port = 8080)

# http://localhost:8080/collectOneSecond

# http://localhost:8080/collectOneRead
