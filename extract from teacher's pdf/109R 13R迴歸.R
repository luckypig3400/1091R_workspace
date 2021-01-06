#新套件—可檢測變數間相關
install.packages(c("ggplot2", "GGally"))
# 載入 ggplot2 與 GGally 套件
library(ggplot2)
library(GGally) #資料分布繪製套件
# 由IRIS轉存練習資料檔
my.df <- iris
# 載入 ggplot2 與 GGally 套件
library(ggplot2)
library(GGally) #資料分布繪製套件
# 繪製資料相關矩陣圖
ggpairs(my.df)



# 畫出 XY 散佈圖—可看出兩者間關連，傳統畫法
qplot(x = Sepal.Length,y = Sepal.Width,color = Species, data=my.df)
# 建立多元迴歸模型
my.lm <- lm(Sepal.Length ~ Sepal.Width + Petal.Length +
              Petal.Width,
            data = my.df)
# 查看模型配適結果
summary(my.lm) #模式解釋力(Multiple R-squared)達0.5以上，屬不錯模式
# 查看預測模式
my.lm
#公式：1.85600 + 0.65084 *Sepal.Width + 0.70913* Petal.Length - 0.55648 * Petal.Width



# 安裝並載入 ggfortify 套件 --迴歸診斷圖形相關套件
install.packages("ggfortify")
library(ggfortify)
# 畫出模型診斷用的圖
autoplot(my.lm)
# 常態性檢定
shapiro.test(my.lm$residual) #H0：常態 V.S. H1：非常態p>0.05，表示吻合常態
#常態機率圖(Q-Q圖）的特性，若殘差成45度線則服從常態



# 殘差獨立性檢定
# 安裝 car 套件
install.packages("car")
require(car)
durbinWatsonTest(my.lm)
#H0：殘差彼此獨立V.S. H1：不獨立p>0.05，表示吻合殘差獨立
# 殘差變異數同質性檢定
require(car)
ncvTest(my.lm)
#H0：殘差變異數同質V.S. H1：不同質 p>0.05，表示吻合殘差變異數同質
# 殘差圖均勻分布在-1.0~0.5 之間，亦表示同質



# 新觀測值進行預測
new.iris <- data.frame(Sepal.Width=3.1, Petal.Length=1.6,
                       Petal.Width=0.3)
new.iris
#公式(由係數決定）：1.85600 + 0.65084 *Sepal.Width +0.70913* Petal.Length -0.55648 * Petal.Width
# 預測資料
predict(my.lm, new.iris)
# 預測值應為：4.841268



#另一種迴歸套件-GLM
my.lm2 = glm(Sepal.Length ~ Sepal.Width + Petal.Length +
               Petal.Width, data = my.df, family = 'gaussian')
# glm 相關家族-- # family="gaussian"` 線性模型模型
# `family="binomial"` 邏輯迴歸模型
# `family="poisson"` 卜瓦松迴歸模型
# 模型篩選準則:AIC和BIC是數值越小越好
my.lm2 #可以看出模式
summary(my.lm2)
my.lm #與之前結果比較



diamondsFullData <- diamonds
dd <- diamonds[,c(1,5:10)]
attach(dd)


diamond.lm2 <- lm(price ~ carat+depth + table+x+ y+z,
                  data = dd)
diamond.lm2
summary(diamond.lm2)
