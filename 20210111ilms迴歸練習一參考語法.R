dd <- diamonds[,c(1,5:10)]
attach(dd)

diamond.lm2 <- lm(price ~ carat+depth + table+x+ y+z,
                  data = dd)
diamond.lm2
summary(diamond.lm2)