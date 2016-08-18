#read input files
#CONTROL
svr_filename <- paste(ws_dir_input, "seq_v_random.csv", sep = "")
file.exists(svr_filename)
seq_v_rand <- read.csv(file = svr_filename, header = TRUE)

dim(seq_v_rand)
summary(seq_v_rand)
#View(seq_v_rand)

factor(seq_v_rand$runtype)

pdf(file= paste(ws_dir_figures, "fig2_proc_rand_seq.pdf", sep=""), width = 6, height = 4)
  ggplot(seq_v_rand, aes(proc, time, fill=factor(runtype))) +
    geom_boxplot() +
    scale_x_discrete(labels=1:16) +
    #scale_fill_manual(values = c("yellow", "orange")) +
    xlab("Processor Completion (Fastest to Slowest)") + 
    ylab("Time (n=20)") +
    ggtitle("Processor Time Comparison") +
    theme_bw()
dev.off()
