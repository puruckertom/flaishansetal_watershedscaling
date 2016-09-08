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
    scale_x_discrete(breaks = c(1,5,10,15,20,25,29)) +
    #scale_fill_manual(values = c("yellow", "orange")) +
    xlab("Bin Number") + 
    ylab("Upstream Reaches") +
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
