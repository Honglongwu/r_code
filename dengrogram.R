library(ggplot2)
library(ggdendro)
data(mtcars)
x <- as.matrix(scale(mtcars))
dd.row <- as.dendrogram(hclust(dist(t(x))))
ddata_x <- dendro_data(dd.row)

p2 <- ggplot(segment(ddata_x),aes(x=x,y=y)) + geom_segment(aes(xend=xend, yend=yend))
labs <- label(ddata_x)
labs$group <- c(rep("C1",5),rep("C2",2),rep("C3",4))
p2 + geom_text(data=labs,aes(x=x,y=0,colour=group,label=label))+scale_color_manual(values=c("blue","green","yellow"))

