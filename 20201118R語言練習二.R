getwd()
setwd("D:/R_workspace") 
load("sales_D.RData")
head(sales_D)
str(sales_D)

rtree1 <- rpart(group_p~.,data=sales_D,
                method = "class", control = rpart.control(cp = 0.001))
rtree2 <- rpart(group_p~quartly+catalogue+type+sales2+cost2 +area,data=sales_D,
                method = "class", control = rpart.control(cp = 0.001))
rtree3 <- rpart(group_p~quartly+catalogue+type+sales2+cost2 +area,data=sales_D,
                method = "class", control = rpart.control(cp = 0.05))

install.packages("rattle")
library("rattle")
fancyRpartPlot(rtree1)
fancyRpartPlot(rtree2)
fancyRpartPlot(rtree3)
summary(rtree3)
