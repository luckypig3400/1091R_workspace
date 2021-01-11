#  109 R期中測驗

#1 讀入rsample2020A.xlsx ，請求算年齡介於30～40 的女性之intention總和
install.packages("readxl")
library(readxl)
rsamp<- read_excel("rsample2020A.xlsx")
head(rsamp)

install.packages("dplyr")
library(dplyr)
rsamp %>% filter(sex=="女生") %>% filter(age== "30～40") %>%
  summarise(sum(as.numeric(intention)))

#以下各題請載入student109.RData
#2 敘述統計 描述這組資料的特徵：說明樣本中就讀學校、性別、教育程度的百分比
# G1、G2的平均值
load("student109.RData")
head(student109)
attach(student109)
table(學校別)
table(性別)
table(教育程度)
summary(G1)
summary(G2)

# 3 請以繪圖方式呈現教育程度、性別與G1的關係
install.packages("ggplot2")
library(ggplot2)
ggplot(data=student109) + geom_boxplot(aes(x = G1, color=性別)) +facet_wrap(~教育程度)

#4 請求出G2的99％信賴區間
t.test(G2,conf.level=0.99)  

#5 請判定G1是否影響G2

lmmodelps<-lm(G2~G1)
anova(lmmodelps) #進行總檢定—F檢定，檢定因變數影響是否顯著
summary(lmmodelps) 

#6 請判定學校別是否會對G1造成影響
t.test(G1~學校別)

#7請判定教育程度是否對G2造成影響
bartlett.test(G2~(學校別))
# 變異數同質
y <- aov(G2~學校別,data=student109)
anova(y)

#8 請判定學校別與教育程度是否有影響
chisq.test(學校別,教育程度)
table(學校別,教育程度)
fisher.test(學校別,教育程度)