# this Rscript can be used to draw the NGS reads that located on target region
setwd(dir="/Users/user/bin/R/")
library(ggplot2)                                                                                                                                             
previous_theme <- theme_set(theme_bw())
a <- read.table("chr1_216495191.tmp.dat",header=F)
n <- length(a$V1)/151
h <- 7*n/151+2
png(file="./chr1_216495191.png",width=31,height=h,units="in",res=96)
p <- ggplot(a) + geom_vline(xintercept = 216495193:216495193, colour = "#ffb6c1",size=2.8)
p <- p + geom_text(aes(x=V2,y=V1,label=V3,color=V4),size=2)
p <- p + opts(title="SNP chr1:216495191",plot.title = theme_text(size=20),panel.background=theme_rect(colour=NA))
p <- p + xlab(NULL) + ylab("depth") + coord_cartesian(ylim = c(0, n+2))
p
dev.off()
