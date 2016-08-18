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

#get mean performance times
mean_times <- ddply(proc_v_time, .(processors), summarize, mean_time=mean(time))[,2]
base_mean <- mean_times[1]
speedup <- base_mean/mean_times

#add speedup
proc_v_time$speedup <- proc_1/proc_v_time$time

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

amdahl <- data.frame(cbind(proc,l50,l75,l90,l95,l99))

#line plot
pdf(file= paste(ws_dir_figures, "fig1_procvspeed.pdf", sep=""), width = 4, height = 6)
  ggplot(data=amdahl, aes(x=proc)) +
    geom_line(aes(y = l99, colour = "99%")) +
    geom_point(aes(y = l99, colour = "99%")) +
    geom_line(aes(y = speedup, colour = "no write")) +
    geom_point(aes(y = speedup, colour = "no write")) +
    geom_line(aes(y = l95, colour = "95%")) +
    geom_point(aes(y = l95, colour = "95%")) +
    geom_line(aes(y = l90, colour = "90%")) +
    geom_point(aes(y = l90, colour = "90%")) +
    geom_line(aes(y = l75, colour = "75%")) +
    geom_point(aes(y = l75, colour = "75%")) +
    geom_line(aes(y = l50, colour = "50%"))  +
    geom_point(aes(y = l50, colour = "50%"))  +
    xlab("# Processors") + 
    ylab("Speedup") +
    ggtitle("Speedup versus Number of Processors") +
    theme_bw() + #theme
    theme(legend.position=c(.17, .78)) +
    #theme(legend.title="Scenario") +
    guides(col = guide_legend(title="Scenario",reverse = TRUE))
dev.off()


