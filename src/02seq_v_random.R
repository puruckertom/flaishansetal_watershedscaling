#### total wall time
#read input files
#lakes per bin
wt_filename <- paste(ws_dir_input, "wall_time.csv", sep = "")
file.exists(wt_filename)
wall_time <- read.csv(file = wt_filename, header = TRUE)

dim(wall_time)
summary(wall_time)
colnames(wall_time)

#var_random <- which(wall_time$run_type=="random")
#wall_time <- wall_time[-var_random,]
#var_seq <- which(wall_time$run_type=="seq")
#wall_time <- wall_time[-var_seq,]

#ggplot(seq_v_rand, aes(proc, time, fill=factor(runtype)))
#wall_time$wt_colors <- as.factor(c(rep("firebrick3",40),rep("steelblue",40)))
color_order <- c("firebrick", "firebrick4","steelblue", "steelblue4")
label_order <- c("Random","Random + Write","Seq","Seq + Write")
group_order <- c("Random","Sequential")
wall_time_plot <- ggplot(wall_time, aes(x=run_class, y=time, fill=run_type)) +
                    # fill=factor(run_type)
  scale_fill_manual(values = color_order) +
  labs(x = "Type", y="Processing Time (s)") +
  geom_boxplot(show.legend=TRUE) +
  guides(fill=guide_legend(title=NULL)) +
  theme_bw() + 
  theme(legend.position = "bottom") 
wall_time_plot

pdf(file= paste(ws_dir_figures, "fig2_wall_time.pdf", sep=""), width = 8, height = 6)
  wall_time_plot
dev.off()

#read input files
#CONTROL
svr_filename <- paste(ws_dir_input, "seq_v_random.csv", sep = "")
file.exists(svr_filename)
seq_v_rand <- read.csv(file = svr_filename, header = TRUE)

dim(seq_v_rand)
summary(seq_v_rand)
#View(seq_v_rand)

factor(seq_v_rand$runtype)

seq_rand_proc <- ggplot(seq_v_rand, aes(proc, time, fill=factor(runtype))) +
  geom_boxplot() +
  scale_x_discrete(labels=1:16) +
  scale_fill_manual(values = c("firebrick", "steelblue")) +
  xlab("Processor Completion") + 
  ylab("Time (n=20)") +
  ggtitle("Processor Time Comparison") +
  theme_bw() +
  theme(legend.position=c(.17, .84)) +
  coord_flip() +
  guides(fill=guide_legend(title=NULL, reverse=TRUE))
seq_rand_proc

pdf(file= paste(ws_dir_figures, "fig2_proc_rand_seq.pdf", sep=""), width = 8, height = 6)
  seq_rand_proc
dev.off()

breakout <- ggplot(seq_v_rand, aes(time)) + 
  geom_histogram(data=subset(seq_v_rand,runtype=='random'), fill = "firebrick4", alpha = 0.6, bins=20) + 
  geom_histogram(data=subset(seq_v_rand,runtype=='sequential'), fill = "steelblue4", alpha = 0.6, bins=20) +
  theme_bw() #+
  #labs(x = "Time (s)", y="Count") +
breakout

pdf(file= paste(ws_dir_figures, "fig2_breakout.pdf", sep=""), width = 8, height = 6)
  breakout
dev.off()

###combine into 1 figure
layout_1 <- matrix(c(1,1,2,2,2,1,1,3,3,3), nrow= 2, ncol=5, byrow = TRUE)
plots_1 <- list()
plots_1[[1]] <- wall_time_plot
plots_1[[2]] <- seq_rand_proc
plots_1[[3]] <- breakout
multiplot(plotlist = plots_1, layout = layout_1)

pdf(file= paste(ws_dir_figures, "fig2_proc_write_breakdown.pdf", sep=""), width = 6, height = 8)
  multiplot(plotlist = plots_1, layout = layout_1)
dev.off()

png(file= paste(ws_dir_figures, "fig2_proc_write_breakdown.png", sep=""), width = 10, height = 6, units='in', pointsize=12, res=300)
  multiplot(plotlist = plots_1, layout = layout_1)
dev.off()