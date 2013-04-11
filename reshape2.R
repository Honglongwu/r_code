library(reshape2)
library(ggplot2)
data <- diamonds[1:7]
data.melt <- melt(data,id=c('cut','color','clarity'))
diam.sum <- dcast(data.melt,cut+clarity~variable, subset= .(variable %in% c('price','carat')),mean)
diam.sum$average <- diam.sum$price/diam.sum$carat 
p <- ggplot(diam.sum,aes(cut,average,fill=clarity))
p + geom_bar(position='dodge')