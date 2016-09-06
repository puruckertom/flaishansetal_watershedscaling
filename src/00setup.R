#check to make sure required packages are installed
list.of.packages <- c("ggplot2")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)>0) {install.packages(new.packages)}

#load library dependencies
library(plyr)
library(reshape2)
library(ggplot2)
#library(grid)
#library(gridExtra)
#library(sensitivity)
#library(abind)

#echo environment
Sys.info()
Sys.info()[4]
.Platform
version

#tom epa windows 2
if(Sys.info()[4]=="DZ2626UTPURUCKE"){
  ws_dir<-path.expand("k:/git/flaishansetal_watershedscaling/")
}
#tom mac air
if(Sys.info()[4]=="stp-air"){
  ws_dir<-path.expand("~/git/flaishansetal_watershedscaling/")
}

#subdirectories
ws_dir_input <- paste(ws_dir, "csv_in/", sep = "")
ws_dir_output <- paste(ws_dir, "output/", sep = "")
ws_dir_figures <- paste(ws_dir, "figures/", sep = "")

#run everything
# define distributions for input parameters
#source(paste(vpdir,"src/processors_v_time.R",sep = ""))
