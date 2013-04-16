################# 1. Clear working space ###############
rm(list=ls())

################ 2. load packages ####################
## make sure you have them installed
require(doBy)
require(plyr)
require(rworldmap)
require(TeachingDemos)
require(ReadImages)

################ 3. make trade data #################
### make sure your country names is by UN convention
### Otherwise you need to modify your countries names
trade.data <- data.frame(Country=c("China",
                                   "United States",
                                   "United Kingdom",
                                   "Brazil",
                                   "Indonesia",
                                   "Germany",
                                   "Russia",
                                   "Australia",
                                   "Malaysia",
                                   "South Africa")
)

### fabricate some data for each country
### I just generate numbers ramdomly and make sure
### they are positive
trade.data$product1 <- abs(rnorm(10,10,30))
trade.data$product2 <- abs(rnorm(10,50,30))
trade.data$product3 <- abs(rnorm(10,100,30))
trade.data$product4 <- abs(rnorm(10,150,30))
trade.data$product5 <- abs(rnorm(10,200,30))

################## 4. make our Geo-pie plots #################
### you can find more info make by using
### "?mapPies" commands without the quotes

##### 4.1 merging with existing data
sPDF <- joinCountryData2Map(trade.data,
                            joinCode = "NAME",
                            nameJoinColumn = "Country")

## This the data that we will plot
dF <- sPDF@data

### make our pie plot
par(mai= c(0,0,0.6,0),
    xaxs = "i",
    yaxs = "i")

mapPies(dF =dF,
        nameX="LON",
        nameY="LAT",
        nameZs =c("product1",
                  "product2",
                  "product3",
                  "product4",
                  "product5") ,
        zColours=c("red",
                   "green",
                   "magenta",
                   "yellow",
                   "blue"),
        oceanCol = "lightblue",
        landCol = "wheat",
        addSizeLegend=F,
        addCatLegend=F,
        mapRegion="world",
        xlim=c(-181,181),
        ylim=c(-81,80))

title(main=paste("Our lovely Geo-Pie plot using rworldmap package"),
      cex=3)

legend(-180.1516,90,
       legend=c("Product 1",
                "Product 2",
                "Product 3",
                "Product 4",
                "Product 5"),
       col=c("red",
             "yellow",
             "green",
             "magenta",
             "blue"),
       pch=16,
       cex=0.8,
       pt.cex=1.5,
       bty="o",
       box.lty=0,
       horiz = F,
       bg="#FFFFFF70")

################ 5. Lets make a barplot on our map ##############
## derive the data for barplot -- top 10 markets for
## product1
tmp_product1 <- orderBy(~-product1,dF)[1:10,]

### make the barplot as a function
subp1.1 <- function(...){
  barplot(rev(tmp_product1$product1),
          width=1,
          names.arg=rev(tmp_product1$Country),
          las=2,
          border="transparent",
          horiz=T,
          col="darkgrey",
          main=paste("Top 10 markets for product 1"),
          cex.main=0.7
  )
  mtext(1,
        text="NZ$ million",
        line=1.7,
        cex=0.7
  )
  grid(col="black")
}

################# 6. plot the barplot and make a bit more lovely ##
#### make our background for the barplot
#### you have to fiddle a bit on the position
subplot(rect(-180,-90,-100,-32,
             col="#FFFFFF70",
             border=NA),
        x=0,
        y=0,
        vadj=1,
        hadj=1)

#### let's plot
w_x <- 0.66
w_y <- 1
pos <- c(-160,-81)

par(mar=c(4,4,1,1),
    cex.axis=0.7,
    cex.lab=0.7,
    bg="white",
    cex.main=0.7)

subplot(subp1.1(),
        x=pos[1],
        y=pos[2],
        size=c(w_x,w_y)
)
############ 7. (Optional) put a logo on your map ###############
rblog <- read.jpeg("world_map.jpeg")
#Get the plot information so the image will fill the plot box, and draw it
pos_rblog <- c(150.7,58.4,181,73.8)
rasterImage(rblog,
            pos_rblog[1],
            pos_rblog[2],
            pos_rblog[3],
            pos_rblog[4])
rect(pos_rblog[1],
     pos_rblog[2],
     pos_rblog[3],
     pos_rblog[4],border="black",
)