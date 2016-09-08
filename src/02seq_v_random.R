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
wall_time <- ggplot(wall_time, aes(factor(run_type), time, fill=factor(run_type))) +
  geom_boxplot() +
  #scale_y_continuous(limits=c(0,max(wall_time$time))) +
  #guides(fill=FALSE) +
  #theme_bw() +
  #theme(legend.position = "none",  axis.title.x=element_blank(), axis.text.x=element_blank())
wall_time

pdf(file= paste(ws_dir_figures, "fig2_wall_time.pdf", sep=""), width = 8, height = 6)
  wall_time
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
  guides(fill=guide_legend(title=NULL, reverse=TRUE))

pdf(file= paste(ws_dir_figures, "fig2_proc_rand_seq.pdf", sep=""), width = 8, height = 6)
  seq_rand_proc
dev.off()

breakout <- ggplot(seq_v_rand, aes(time)) + 
  geom_histogram(data=subset(seq_v_rand,runtype=='random'), fill = "red", alpha = 0.2) + 
  geom_histogram(data=subset(seq_v_rand,runtype=='sequential'), fill = "blue", alpha = 0.2) +
  theme_bw()

pdf(file= paste(ws_dir_figures, "fig2_breakout.pdf", sep=""), width = 8, height = 6)
  breakout
dev.off()


dat <- data.frame(xx = c(runif(100,20,50),runif(100,40,80),runif(100,0,30)),yy = rep(letters[1:3],each = 100))

colnames(seq_v_rand)
colnames(dat)
ggplot(dat,aes(x=xx)) + 
  geom_histogram(data=subset(dat,yy == 'a'),fill = "red", alpha = 0.2) +
  geom_histogram(data=subset(dat,yy == 'b'),fill = "blue", alpha = 0.2) +
  geom_histogram(data=subset(dat,yy == 'c'),fill = "green", alpha = 0.2)

#combine into 1 figure
layout <- matrix(c(1,2,2,3,3,3), nrow= 2, byrow = TRUE)
plots <- list()
plots[[1]] <- wall_time
plots[[2]] <- breakout
plots[[3]] <- seq_rand_proc
proc_write_breakdown <- multiplot(plotlist = plots, layout = layout)

pdf(file= paste(ws_dir_figures, "fig2_proc_write_breakdown.pdf", sep=""), width = 8, height = 8)
  multiplot(plotlist = plots, layout = layout)
dev.off()
