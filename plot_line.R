# make a data manually
df1 <- df1 <- data.frame(sex       = factor(c("Female","Female","Male","Male")),
                         time       = factor(c("Lunch","Dinner","Lunch","Dinner"), levels=c("Lunch","Dinner")),
                         total_bill = c(13.53, 16.81, 16.24, 17.42))
library(ggplot2)
p <- ggplot(data=df1, aes(x = time, y = total_bill, group = sex, colour = sex))
p + geom_line(aes(linetype=sex), size = 1) + ylim(0, max(df1$total_bill)) + geom_point(size = 3, fill = "white") + scale_colour_hue(name = "Sex of payer", l = 30) +
  scale_shape_manual(name = "test",values = c(19,22)) + scale_linetype_discrete(name = "Sex of payer") +
  theme_bw() + theme(legend.position=c(.7,.4))