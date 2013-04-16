library(ggmap)
library(animation)
library(XML)# 从网页上抓取数据，并进行清理
webpage <-'http://data.earthquake.cn/datashare/globeEarthquake_csn.html'
tables <- readHTMLTable(webpage,stringsAsFactors = FALSE)
raw <- tables[[6]]
data <- raw[-1,c(1,3,4)]
names(data) <- c('date','lan','lon')
data$lan <- as.numeric(data$lan)
data$lon <- as.numeric(data$lon)
data$date <- as.Date(data$date,  "%Y-%m-%d")# 用ggmap包从google读取地图数据，并将之前的数据标注在地图上。
ggmap(get_googlemap(center = 'china', zoom=4,maptype='terrain'),extent='device')+geom_point(data=data,aes(x=lon,y=lan),colour = 'red',alpha=0.7)+stat_density2d(aes(x=lon,y=lan,fill=..level..,alpha=..level..), size=2,bins=4,data=data,geom='polygon')+opts(legend.position = "none") 
#更好玩的作法就是根据地震发生的日期生成不同的静态图，然后用animaiton包将其整合为一个gif动画。
# 为了生成动画，先准备好一个绘图函数
plotfunc <- function(x) {  
  df <- subset(data,date <= x)  
  df$lan <- as.numeric(df$lan)    
  df$lon <- as.numeric(df$lon)   
  p <- ggmap(get_googlemap(center = 'china', zoom=4,maptype='terrain'),,extent='device')+ geom_point(data=df,aes(x=lon,y=lan),colour = 'red',alpha=0.7)
}
# 获取地震的日期
time <- sort(unique(data$date))
# 生成并保存动画
saveMovie(for( i in time) print(plotfunc(i)))