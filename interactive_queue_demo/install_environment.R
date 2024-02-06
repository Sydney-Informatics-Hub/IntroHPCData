# Demonstrates installing packages via interactive session to a location you have write access to.
# This enables run_stuff.pbs

# Type the below and notice that when the interactive queue starts
# it changes your directory which can be rechanged.

# On Artmis Terminal:

# qsub -I -P Training -l select=1:ncpus=4:mem=4gb -l walltime=00:30:00
# module load R/4.3.2
# R

install.packages(c("renv", "here", "glmulti", "foreach", "doParallel", "memisc", "survival"),lib = "/project/Training/km5/libs",repos="https://cran.csiro.au/") #need to point to a location you have write access to
install.packages("BiocManager",lib = "/project/Training/km5/libs",repos="https://cran.csiro.au/")
install.packages("devtools",lib = "/project/Training/km5/libs",repos="https://cran.csiro.au/")
install.packages("tidyverse",lib = "/project/Training/km5/libs")
require(devtools)
require(BiocManager)
BiocManager::install("methylKit",lib = "/project/Training/km5/libs")

# Save workspace image? [y/n/c]: y
# exit
