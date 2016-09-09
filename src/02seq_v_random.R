<<<<<<< HEAD
#### total wall time
#read input files
#lakes per bin
wt_filename <- paste(ws_dir_input, "wall_time.csv", sep = "")
file.exists(wt_filename)
wall_time <- read.csv(file = wt_filename, header = TRUE)

dim(wall_time)
summary(wall_time)
colnames(wall_time)

var_random <- which(wall_time$run_type=="random")
wall_time <- wall_time[-var_random,]
var_seq <- which(wall_time$run_type=="seq")
wall_time <- wall_time[-var_seq,]

#ggplot(seq_v_rand, aes(proc, time, fill=factor(runtype)))
wall_time_plot <- ggplot(wall_time, aes(factor(run_type), time, fill=factor(run_type))) +
  geom_boxplot(show.legend=FALSE) +
  #theme(legend.position = "none",  axis.title.x=element_blank(), axis.text.x=element_blank()) +
  theme_bw()
  #coord_flip()
  #scale_y_continuous(limits=c(0,max(wall_time$time))) +
  #guides(fill=FALSE) +
  #theme_bw() +
  #theme(legend.position = "none",  axis.title.x=element_blank(), axis.text.x=element_blank())
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
  #scale_fill_manual(values = c("yellow", "orange")) +
  xlab("Processor Completion (Fastest to Slowest)") + 
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
  geom_histogram(data=subset(seq_v_rand,runtype=='random'), fill = "red", alpha = 0.2) + 
  geom_histogram(data=subset(seq_v_rand,runtype=='sequential'), fill = "blue", alpha = 0.2) +
  theme_bw()
breakout

pdf(file= paste(ws_dir_figures, "fig2_breakout.pdf", sep=""), width = 8, height = 6)
  breakout
dev.off()



###combine into 1 figure
layout_1 <- matrix(c(1,2,2,1,3,3), nrow= 2, ncol=3, byrow = TRUE)
plots_1 <- list()
plots_1[[1]] <- wall_time_plot
plots_1[[2]] <- seq_rand_proc
plots_1[[3]] <- breakout
multiplot(plotlist = plots_1, layout = layout_1)


proc_write_breakdown <- multiplot(plotlist = plots_1, layout = layout_1)


pdf(file= paste(ws_dir_figures, "fig2_proc_write_breakdown.pdf", sep=""), width = 6, height = 8)
  multiplot(plotlist = plots_1, layout = layout_1)
dev.off()
=======
#### total wall time
#read input files
#lakes per bin
wt_filename <- paste(ws_dir_input, "wall_time.csv", sep = "")
file.exists(wt_filename)
wall_time <- read.csv(file = wt_filename, header = TRUE)

dim(wall_time)
summary(wall_time)
colnames(wall_time)

var_random <- which(wall_time$run_type=="random")
wall_time <- wall_time[-var_random,]
var_seq <- which(wall_time$run_type=="seq")
wall_time <- wall_time[-var_seq,]

#ggplot(seq_v_rand, aes(proc, time, fill=factor(runtype)))
#wall_time$wt_colors <- as.factor(c(rep("firebrick3",40),rep("steelblue",40)))
wall_time_plot <- ggplot(wall_time, aes(factor(run_type), time, fill=factor(run_type))) +
  geom_boxplot(show.legend=FALSE) +
  scale_fill_manual(name = "This is my title", values = c("firebrick3", "steelblue"),
                    labels = c("random_io" = "Foo", "seq_io" = "Bar")) +
  #scale_colour_manual(values = c("firebrick3",  "steelblue")) +
  #theme(legend.position = "none",  axis.title.x=element_blank(), axis.text.x=element_blank()) +
  theme_bw()
  #coord_flip()
  #scale_y_continuous(limits=c(0,max(wall_time$time))) +
  #guides(fill=FALSE) +
  #theme_bw() +
  #theme(legend.position = "none",  axis.title.x=element_blank(), axis.text.x=element_blank())
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
  #scale_fill_manual(values = c("yellow", "orange")) +
  xlab("Processor Completion (Fastest to Slowest)") + 
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
  geom_histogram(data=subset(seq_v_rand,runtype=='random'), fill = "firebrick3", alpha = 0.6) + 
  geom_histogram(data=subset(seq_v_rand,runtype=='sequential'), fill = "steelblue", alpha = 0.6) +
  theme_bw()
breakout

pdf(file= paste(ws_dir_figures, "fig2_breakout.pdf", sep=""), width = 8, height = 6)
  breakout
dev.off()



###combine into 1 figure
layout_1 <- matrix(c(1,2,2,1,3,3), nrow= 2, ncol=3, byrow = TRUE)
plots_1 <- list()
plots_1[[1]] <- wall_time_plot
plots_1[[2]] <- seq_rand_proc
plots_1[[3]] <- breakout
multiplot(plotlist = plots_1, layout = layout_1)


proc_write_breakdown <- multiplot(plotlist = plots_1, layout = layout_1)


pdf(file= paste(ws_dir_figures, "fig2_proc_write_breakdown.pdf", sep=""), width = 6, height = 8)
  multiplot(plotlist = plots_1, layout = layout_1)
dev.off()
>>>>>>> 9e62dea4a3079ba051f8ef713a2f7c35ce7a368b
