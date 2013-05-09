library(rgl)
library(animation)

t <- seq(0, 360, by=30)
plot3df <- function(x)
{
  plot3d(cos(x),sin(x),10*x, size=2,type="p",col="red",box=F,axes=F,xlab="",ylab="",zlab="", zlim=c(0,360), xlim=c(cos(0),cos(360)),ylim=c(sin(0),sin(360)))
  bm= sprintf("plot%d",x)
  rgl.postscript("/var/folders/q3/lkr3gq254zvbs_hrv95jg0k80000gn/T//Rtmp2kZQ6l/bm", fmt="pdf")
}

saveMovie(for(i in t) plot3df(i))