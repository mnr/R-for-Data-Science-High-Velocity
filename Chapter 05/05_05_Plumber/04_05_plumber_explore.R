

# Set Up ------------------------------------------------------------------

# check your working directory so that collectOneSecond can be found
install.packages("plumber")
library(plumber)


# Collect One Second of Data ----------------------------------------------


api <- plumb("04_06_functions.R")
api$run(port = 8080)

# http://localhost:8080/collectOneSecond

# http://localhost:8080/collectOneRead
