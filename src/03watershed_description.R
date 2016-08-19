#read input files
#CONTROL
ws_filename <- paste(ws_dir_input, "lakes_per_bin.csv", sep = "")
file.exists(ws_filename)
lakes_per_bin <- read.csv(file = ws_filename, header = TRUE)

dim(lakes_per_bin)
summary(lakes_per_bin)
#View(lakes_per_bin)

#ggplot(lakes_per_bin, aes(x=bin)) +
#  geom_histogram()


qplot(bin, data=lakes_per_bin, weight=Lakes, geom="histogram", xlab="Bin ID", 
      ylab="Number of Lakes", xlim=c(1,29), fill=I("blue"), col=I("blue"), binwidth=1) + 
  theme_bw()
