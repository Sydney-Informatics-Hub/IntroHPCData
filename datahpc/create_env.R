
# Specify a location you have write access to
install.packages("renv",lib = "~/R/library",repos="https://cran.csiro.au/")

# Tells R to look for libraries in your specified location
.libPaths( c( .libPaths(), "~/R/library") )

# Use R as normal...
library(renv)
library(here)
load_file <- here::here("renv.lock")
print(load_file)
renv::restore(lockfile = load_file, library = "~/R/library")
sessionInfo()
