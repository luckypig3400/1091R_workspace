#決策樹二—類別資料CHAID
install.packages("CHAID", repos="http://R-Forge.Rproject.org")
library(CHAID)
install.packages("ggplot2")
library(ggplot2)
head(diamonds)
str(diamonds)
attach(diamonds)
CHtree<- chaid(cut~color+clarity,data=diamonds, control =
                   chaid_control(0.001))
summary(CHtree)
par(mfrow = c(1,1),xpd = NA)
plot(CHtree)

# chaid -鐵達尼資料
load("titanic.raw.RData")
head(titanic.raw)
str(titanic.raw)
attach(titanic.raw)
# CHAID的模型：把存活與否的變數(Survived)當
# 作Y，剩下的變數當作X （需為屬質變數）
CHAID.model<- chaid(Survived ~. ,data=titanic.raw)
plot(CHAID.model)
summary(CHAID.model)

#三、剪枝
#A.rpart 不剪枝
#思考Kyphosis資料集適合用哪種方法？
head(kyphosis) #內建於rpart，Kyphosis（有、無）、 Age（月）、Number（次數） 、Start（何時開始）
attach(kyphosis)#持續使用該資料集
par(mfrow = c(1,2),xpd = NA)
rtree1 <- rpart(Kyphosis~Age+Number+Start)
plot(rtree1,main = '不剪枝')
text(rtree1,use.n = TRUE)
summary(rtree1)

#剪枝
rtree2 <- rpart(Kyphosis~Age+Number+Start,control = rpart.control(cp = 0.05))
plot(rtree2,main = '剪枝')
text(rtree2,use.n = TRUE)
summary(rtree2)