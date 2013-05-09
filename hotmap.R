library(ggplot2)
# 数据处理
hotmap <- read.table("r_code/hotmap.txt")
colnames(hotmap) <- c("element","cell_type","pattern","density","methylation")
# 缺少 genome的数据,所以加上genome的数据以后在下面的levels中增加"genome" 因子
# 图的排列方式可以根据自己的要求对levels里面的顺序进行修改
hotmap$element <- factor(hotmap$element, levels=c("upstream","5-UTR","CDS","intron","3-UTR","downstream","Alu","CpG","DNA","ERV1","L1","L2","MIR","rRNA","tRNA","other_LINE","other_LTR","other_ncRNA","PseudoGene","Tandem_repeats"), ordered=TRUE)

# 绘图 
# 如果需要修改其他参数可以在theme中进行
p <- ggplot(data = subset(hotmap, pattern=="CG"), aes(x = density, y = methylation, color=cell_type)) + geom_point() + geom_smooth() + xlim(c(0,0.2)) + ylim(c(0,1)) + scale_x_log10(breaks=c(0.005,0.05,0.2))  + facet_wrap(~element) + labs(x="CpG density",y="Average methylation level")
ggsave(p, filename="r_code/hotmap.pdf")