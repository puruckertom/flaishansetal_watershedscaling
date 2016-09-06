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



#read input files
#lakes per bin
ws_filename <- paste(ws_dir_input, "lakes_per_bin.csv", sep = "")
file.exists(ws_filename)
lakes_per_bin <- read.csv(file = ws_filename, header = TRUE)

dim(lakes_per_bin)
summary(lakes_per_bin)
#View(lakes_per_bin)

#ggplot(lakes_per_bin, aes(x=bin)) +
#  geom_histogram()


lakes_per_bin <- qplot(bin, data=lakes_per_bin, weight=Lakes, geom="histogram", xlab="Bin ID", 
    ylab="Number of Lakes", xlim=c(1,29), fill=I("blue"), col=I("blue"), binwidth=1) + 
    theme_bw()

pdf(file= paste(ws_dir_figures, "fig3_lakes_per_bin.pdf", sep=""), width = 8, height = 6)
  lakes_per_bin
dev.off()

png(file= paste(ws_dir_figures, "fig3_lakes_per_bin.png", sep=""), width = 8, height = 6, units='in', pointsize=12, res=300)
  lakes_per_bin
dev.off()

#upstream reaches per lake
ws_filename <- paste(ws_dir_input, "upstream_reaches_per_bin.csv", sep = "")
file.exists(ws_filename)
reaches_per_bin <- read.csv(file = ws_filename, header = TRUE)
colnames(reaches_per_bin)
summary(reaches_per_bin)


reaches_per_bin <- 
    ggplot(reaches_per_bin, aes(factor(bin), upstream_reaches, fill=factor(bin))) +
    geom_boxplot()+
    scale_x_discrete(labels=1:29) +
    #scale_fill_manual(values = c("yellow", "orange")) +
    xlab("Bin Number") + 
    ylab("Upstream Reaches") +
    scale_x_discrete(breaks = c(1,5,10,15,20,25,29)) +
    ggtitle("") +
    guides(fill=FALSE) +
    theme_bw()

pdf(file= paste(ws_dir_figures, "fig3_reaches_per_bin.pdf", sep=""), width = 8, height = 6)
  reaches_per_bin
dev.off()

png(file= paste(ws_dir_figures, "fig3_reaches_per_bin.png", sep=""), width = 8, height = 6, units='in', pointsize=12, res=300)
  reaches_per_bin
dev.off()

######plot both 4 together
pdf(file= paste(ws_dir_figures, "watershed_description.pdf", sep=""), width = 8, height = 6)
  multiplot(lakes_per_bin, reaches_per_bin, cols=2)
dev.off()

png(file= paste(ws_dir_figures, "watershed_description.png", sep=""), width = 10, height = 6, units='in', pointsize=12, res=300)
  multiplot(lakes_per_bin, reaches_per_bin, cols=2)
dev.off()
