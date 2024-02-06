
#tells R to look for libraries you have installed packages
.libPaths( c( .libPaths(), "/project/Training/km5/libs") )

library(memisc)
library(survival)
library(foreach)
library(doParallel)
library(glmulti)
library(tidyverse)
library(methylKit)
library(tidyverse)

# No errors hopefully
print("this is done without errors")

#some superficial code that uses one of the libraries (tidyverse) 

mtcars %>% group_by(cyl) %>% summarise(mean_disp = mean(disp))
