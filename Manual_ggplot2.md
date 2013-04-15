The introduction of ggplot2
========================================================

scatter point:


```r
library(ggplot2)
library(reshape2)
library(plyr)
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```


plot a scatter plot with Sepal.Length as x axis and Sepal.Width as y axis, for example:


```r
a <- ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + geom_point()
a
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-21.png) 

```r
# change the size of points
b <- ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + geom_point(size = 3)
b
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-22.png) 

```r
# change the color of points
c <- ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) + 
    geom_point()
c
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-23.png) 

```r
# change the shape of points according to species of flowers
d <- ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) + 
    geom_point(aes(shape = Species), size = 3)
d
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-24.png) 


more examples with diamonds data, we want to show some figures fast so to reduce the data size and improve the speed


```r
d2 <- diamonds[sample(1:dim(diamonds)[1], 1000), ]
ggplot(data = d2, aes(x = carat, y = price, color = color)) + geom_point() + 
    theme_gray()
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


boxplot figure with birthwt that from MASS package


```r
library(MASS)
ggplot(data = birthwt, aes(x = factor(race), y = bwt)) + geom_boxplot()
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


histogram figure with faithfull data


```r
ggplot(faithful, aes(x = waiting)) + geom_histogram(binwidth = 8, colour = "black", 
    fill = "steelblue")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


line figure with climate data from gcookbook

```r
library(gcookbook)
a <- ggplot(data = climate, aes(x = Year, y = Anomaly10y)) + geom_line()
a
```

```
## Warning: Removed 10 rows containing missing values (geom_path).
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-61.png) 

```r
b <- ggplot(data = climate, aes(x = Year, y = Anomaly10y)) + geom_ribbon(aes(ymin = Anomaly10y - 
    Unc10y, ymax = Anomaly10y + Unc10y), fill = "blue", alpha = 0.1) + geom_line(color = "steelblue")
b
```

```
## Warning: Removed 10 rows containing missing values (geom_path).
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-62.png) 

```r
cplot <- ggplot(climate, aes(Year, Anomaly10y))
cplot <- cplot + geom_line(size = 0.7, color = "black")
cplot <- cplot + geom_line(aes(Year, Anomaly10y + Unc10y), linetype = "dashed", 
    size = 0.7, color = "red")
cplot <- cplot + geom_line(aes(Year, Anomaly10y - Unc10y), linetype = "dashed", 
    size = 0.7, color = "red")
cplot + theme_gray()
```

```
## Warning: Removed 10 rows containing missing values (geom_path).
```

```
## Warning: Removed 16 rows containing missing values (geom_path).
```

```
## Warning: Removed 16 rows containing missing values (geom_path).
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-63.png) 


bar plot with iris data

```r
ggplot(iris, aes(Species, Sepal.Length)) + geom_bar(stat = "identity")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-71.png) 

```r
df <- melt(iris, id.vars = "Species")
bar_stat <- ggplot(data = df, aes(x = Species, y = value, fill = variable)) + 
    geom_bar(stat = "identity", position = "dodge")
bar_stat + coord_flip()
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-72.png) 

```r

color_try <- ggplot(df, aes(Species, value, fill = variable)) + geom_bar(stat = "identity", 
    position = "dodge") + scale_fill_manual(values = c("red", "blue", "green", 
    "yellow")) + facet_wrap(~Species)
color_try
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-73.png) 

```r
color_try2 <- ggplot(df, aes(Species, value, fill = variable)) + geom_bar(stat = "identity", 
    position = "dodge") + scale_fill_manual(values = c("red", "blue", "green", 
    "yellow")) + facet_grid(Species ~ .)
color_try2
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-74.png) 

```r
color_try3 <- ggplot(df, aes(Species, value, fill = variable)) + geom_bar(stat = "identity", 
    position = "dodge") + scale_fill_manual(values = c("red", "blue", "green", 
    "yellow")) + facet_grid(. ~ Species)
color_try3
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-75.png) 


add some statistical result to the figure

```r
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) + 
    geom_point(aes(shape = Species), size = 3) + geom_smooth(method = "lm") + 
    facet_grid(Species ~ .)
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 


modify the theme of ggplot2

```r
defa <- ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) + geom_point(size = 1.2, 
    shape = 16) + facet_wrap(~Species) + theme()
defa
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-91.png) 

```r
lk <- ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) + geom_point(size = 1.2, 
    shape = 16) + facet_wrap(~Species) + theme(legend.key = element_rect(fill = NA))
lk
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-92.png) 

```r
ld <- lk + theme(legend.position = "bottom")
ld
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-93.png) 

```r
lz <- ld + theme(strip.background = element_rect(fill = NA))
lz
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-94.png) 

```r
lw <- lz + theme(axis.title.y = element_text(angle = 30))
lw
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-95.png) 

```r
lline <- lw + theme(panel.grid.major = element_line(color = "black", linetype = "dashed"), 
    panel.grid.minor = element_line(color = "grey", linetype = "dashed"))
lline
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-96.png) 


in the following days, I will add more example with ggplot2.



