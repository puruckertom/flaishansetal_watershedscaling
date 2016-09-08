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

########### control daily sensitivity plot
# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}



#run everything
# define distributions for input parameters
#source(paste(vpdir,"src/processors_v_time.R",sep = ""))
