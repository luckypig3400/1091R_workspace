#決策樹二—類別資料CHAID
install.packages("CHAID", repos="http://R-Forge.R-project.org")
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



# chaid -鐵達尼資料
load("titanic.raw.RData")
head(titanic.raw)
str(titanic.raw)
attach(titanic.raw)
# CHAID的模型：把存活與否的變數(Survived)當作Y，剩下的變數當作X （需為屬質變數）
CHAID.model<- chaid(Survived ~. ,data=titanic.raw)
plot(CHAID.model)
summary(CHAID.model)



# 三、剪枝
#剪枝
#A.rpart 不剪枝
#思考Kyphosis資料集適合用哪種方法？
head(kyphosis) #內建於rpart，Kyphosis（有、無）、 Age（月）、Number（次數） 、Start（何時開始）
attach(kyphosis)#持續使用該資料集
par(mfrow = c(1,2),xpd = NA)
rtree1 <- rpart(Kyphosis~Age+Number+Start)
plot(rtree1,main = '不剪枝')
text(rtree1,use.n = TRUE)
summary(rtree1)



#剪枝
rtree2 <- rpart(Kyphosis~Age+Number+Start,control
                = rpart.control(cp = 0.05))
plot(rtree2,main = '剪枝')
text(rtree2,use.n = TRUE)
summary(rtree2)



#模式部署與模式評估
#程式碼參考台大計中林淑芬程式設計師
#模式評估與部署
install.packages("C50")
library(C50)
n=0.3*nrow(iris) #70%訓練資料、30％驗證資料，設定應有的測試
資料數量
test.index=sample(1:nrow(iris),n)#隨機抽取n筆驗證資料30％
iris.train=iris[-test.index,] #剔除所選取驗證資料而成為訓練資料
iris.test=iris[test.index,]
#-----------2.以訓練資料產生決策樹模式
irismodel=C5.0(Species~ . ,data=iris)
summary(irismodel)
plot(irismodel)



#-----------3.train confusion matrix-製作訓練資料的混淆矩陣
species.train=iris$Species[-test.index] #存訓練資料各筆資料之品種名稱
train.pred=predict(irismodel,iris.train,type='class') #存「模式中所判定」的品種名稱
table.train=table(species.train,train.pred) #製作訓練與預測資料中的品種列聯表
table.train
cat("Total records(train)=",nrow(iris.train),"\n")#cat:為輸出函數
cat("Correct Classification Ratio(train)=",
    sum(diag(table.train))/sum(table.train)*100,"%\n")
#----------4.test confusion matrix-以驗證資料製作製作混淆矩陣
species.test=iris$Species[test.index]
test.pred=predict(irismodel,iris.test,type='class')
table.test=table(species.test,test.pred)
table.test
cat("Total records(test)=",nrow(iris.test),"\n")
cat("Correct Classification Ratio(test)=",
    sum(diag(table.test))/sum(table.test)*100,"%\n")



#----------5.irisnew2.txt模式部署-用新資料進行預測
irisnew2=read.table("iris_new2.txt",header=T,sep=",")
iris.pred=predict(irismodel,irisnew2,type='class')#以PREDICT函數進行預測-給予模式以及資料
irisall=data.frame(irisnew2,Spec.Pred=iris.pred)#合併新資料與預測值merge predict result and output
irisall



#決策樹function 通用語法
result=函數名稱(Y~X1+X2+…+Xk, 其他選項)
# Y若為類別變數, 需設為factor型態
pred<-predict(result, new_X_data, type="class")
# 混淆矩陣(confusion matrix)
ctable<-table(Y真實值, pred)
# 預測正確率
sum(diag(ctable))/sum(ctable)



# R機器學習基本語法
n=0.3*nrow(iris) #70%訓練資料、30％驗證資料，設定應有的測試資料數量
test.index=sample(1:nrow(iris),n)#隨機抽取n筆驗證資料30％
iris.train=iris[-test.index,] #剔除所選取驗證資料而成為訓練資料
iris.test=iris[test.index,]



# 佈署：將建立好模式，運用於新資料
#C5.0 irisnew2.txt模式部署-用新資料進行預測1.讀入新資料檔
library(C50)
irisnew2=read.table("iris_new2.txt",header=T,sep=",")
#2.用 C5.0建立決策樹模式
#iris.tree=C5.0(Species~ . ,data=iris) #建立模型，如之前已建立，則無須再執行
#3. 以predict函數預測 irisnew2的品種
iris.pred=predict(iris.tree,irisnew2,type='class')#以PREDICT函數進行預測-給予模式以及資料
#4. 整合要預測的資料及預測的結果
irisall=data.frame(irisnew2,Spec.Pred=iris.pred)
irisall


