#一、R決策樹基本套件---- #A.C5.0
install.packages("C50")
library(C50)
irisFullData <- iris
c50tree=C5.0(Species~ .,data=iris) # iris R內建資料集
summary(c50tree)
plot(c50tree)



#B.rpart
install.packages("rpart")
library(rpart)
rptree <- rpart(Species~ .,data=iris,
                method = "class", control = rpart.control(cp = 0.001))
#method 也有"anova"
#h control = 可作為剪枝的法則--調整 cp = 的值
par(mfrow = c(1,2),xpd = NA) #圖形的座標是從R裡面圖形視窗的邊框開始算
plot(rptree)
text(rptree,use.n = TRUE)
#可以比較用rattle來畫rpart的圖
install.packages("rattle")
library("rattle")
fancyRpartPlot(rptree)
summary(rptree)



#C.tree
install.packages("tree")
library(tree)
par(mfrow = c(1,1),xpd = NA) #圖形的座標是從R裡面圖形視窗的邊框開始算
t_tree<-tree(Species~ .,data=iris)
plot(t_tree)
text(t_tree)
summary(t_tree)



#模式簡易部署
setwd("D:\\")
getwd()
irisnew2=read.table("iris_new2.txt",header=T,sep=",")
iris.pred=predict(c50tree,irisnew2,type='class')#以PREDICT函數進行預測-給予模式以及資料
iris.pred
irisall=data.frame(irisnew2,iris.pred)#合併新資料與預測值merge predict result and output
irisall #簡易方法，模式好壞並未評估
iris.pred=predict(rptree,irisnew2,type='class')#改用rpart模式進行預測-給予模式以及資料
iris.pred



# practice 1
install.packages("AER")
library(AER)
data(CreditCard)
head(CreditCard) 
# 因變數：card，自變數—選：reports, age. income,expenditure, owner, dependents, active



# practice 2
# 載入sales_D.Rdata，因變數： group_p，挑選不同變數，調整control = rpart.control(cp = 0.001)—剪枝，
# 如：0.05等去做調整
load("sales_D.RData")
head(sales_D)
str(sales_D)