#read input files
#CONTROL
tvp_filename <- paste(ws_dir_input, "time_v_processor.csv", sep = "")
file.exists(tvp_filename)
proc_v_time <- read.csv(file = tvp_filename, header = TRUE)

dim(proc_v_time)
summary(proc_v_time)
#View(proc_v_time)

#calculate base mean
proc_1 <- proc_v_time[proc_v_time$processors==1,2]
mean(proc_1)

#get mean performance times for model_only, others dont have replication
mean_times <- ddply(proc_v_time, .(processors), summarize, mean_time=mean(model_only))[,2]
base_mean <- mean_times[1]
speedup_model_only <- base_mean/mean_times

#others
speedup_model_w_io_vector <- proc_v_time$model_w_io[!is.na(proc_v_time$model_w_io)]
speedup_model_w_io <- speedup_model_w_io_vector[1]/speedup_model_w_io_vector
speedup_post_process_vector <- proc_v_time$post_process[!is.na(proc_v_time$post_process)]
speedup_post_process <- speedup_model_post_process[1]/speedup_model_post_process


#add wall time for serial write

#add speedup with no write
proc_v_time$speedup <- proc_1/proc_v_time$model_only

#fig1 <- ggplot(proc_v_time, aes(processors), speedup)
#fig1 + geom_boxplot()

#amdahl
proc <- c(1,2,4,8,16,24,32)

p50 = 0.5
p75 = 0.75
p90 = 0.9
p95 = 0.95
p99 = 0.99

#1/(fixed + parallelized)
l50 = 1/((1-p50) + p50/proc)
l75 = 1/((1-p75) + p75/proc)
l90 = 1/((1-p90) + p90/proc)
l95 = 1/((1-p95) + p95/proc)
l99 = 1/((1-p99) + p99/proc)

amdahl_df <- data.frame(cbind(proc,l50,l75,l90,l95,l99,
                speedup_model_only,speedup_model_w_io,speedup_post_process))
View(amdahl_df)

amdahl_melt <- melt(amdahl_df, id.vars="proc")
dim(amdahl_melt)
summary(amdahl_melt)
View(amdahl_melt)

amdahl_melt$variable <- factor(amdahl_melt$variable, 
    levels = c("l99","speedup_model_only","l95","speedup_model_w_io","l90","l75","speedup_post_process","l50"),
    labels=c("99%","Model only","95%","Model with IO","90%","75%","Post-processing","50%")
    )
View(amdahl_melt)

#line plot
pdf(file= paste(ws_dir_figures, "fig1_procvspeed.pdf", sep=""), width = 4, height = 6)
  ggplot(data=amdahl, aes(x=proc,y=value, group=variable)) +
    geom_line() +
    geom_point() +
    xlab("# Processors") + 
    ylab("Speedup") +
    ggtitle("Speedup versus Number of Processors") +
    theme_bw() + #theme
    theme(legend.position=c(.23, .78)) +
    #theme(legend.title="Scenario") +
    guides(col = guide_legend(title="Scenario",reverse = TRUE))
dev.off()


