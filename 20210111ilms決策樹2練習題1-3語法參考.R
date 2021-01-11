#練習1 credit card data
#因變數：card，自變數—選：reports, age. income, expenditure, owner, dependents, active
install.packages("AER")
library(AER)
data(CreditCard)
head(CreditCard)
attach(CreditCard)

#1. c50
library(C50)
c50tree=C5.0(card~ .,data=CreditCard) 
summary(c50tree)
plot(c50tree)


c50tree1=C5.0(card~ reports+age+income+expenditure+owner+months,
               data=CreditCard, control= C5.0Control(0.001))  # 不易解釋，應當剪枝
plot(c50tree1)
summary(c50tree1)
c50tree2=C5.0(card~ reports+age+income+owner+months,
              data=CreditCard, control= C5.0Control(0.005))  # 不易解釋，應當剪枝
plot(c50tree2)
summary(c50tree2)

#2A. tree
install.packages("tree")
library(tree)
ttree1 <- tree(card~.,
                data = CreditCard)
plot(ttree1)
text(ttree1)
summary(ttree1)

#2B. tree
ttree2 <- tree(card~ reports+age+income+owner+months+expenditure,
               data = CreditCard)
plot(ttree2)
text(ttree2)
summary(ttree2)

#3A. rpart
install.packages("rattle")
library("rattle")
install.packages("rpart")
library(rpart)
rtree1 <- rpart(card~ reports+age+income+owner+months+expenditure,
            data = CreditCard,method = "class",control = rpart.control(cp = 0.001))

fancyRpartPlot(rtree1)
#expenditure 解釋力過強

#3B. rpart
rtree2 <- rpart(card~ reports+age+income+owner+months,
                  data = CreditCard,method = "class",control = rpart.control(cp = 0.01))
fancyRpartPlot(rtree2)
summary(rtree2)


#練習2  
getwd()
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
summary(rtree1)

#練習3：使用ggplot2的diamonds 資料練習跑決策樹，找出切割完美與否的影響因素（類別樹），以及價格的影響因素（數值樹）
install.packages("ggplot2")
library(ggplot2)
head(diamonds)

#3A用C50
d_tree<-C5.0(cut~.,data=diamonds)
summary(d_tree)
plot(d_tree)  #z費時相當久

d_tree1<-C5.0(price~.,data=diamonds)
#無法用來分析數值樹-迴歸樹

#3B用rpart
r_tree<-rpart(cut~.,data=diamonds)
fancyRpartPlot(r_tree)
summary(r_tree)

#3C rpart 剪枝
r_tree2<-rpart(cut~.,data=diamonds,control = rpart.control(cp = 0.05) )
fancyRpartPlot(r_tree2)
summary(r_tree2)

#3D tree 類別樹
t_tree<-tree(cut~.,data=diamonds)
plot(t_tree)
text(t_tree)
summary(t_tree)

#4.數值樹
t_tree<-tree(price~.,data=diamonds)
plot(t_tree)
text(t_tree)
summary(t_tree)