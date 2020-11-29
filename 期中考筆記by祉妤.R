load("product.RData")
install.packages("ggplot2")
install.packages("dplyr")
library(ggplot2)
library(dplyr)
attach(product)#這個很重要，要寫!! 這個為了不用在每個變數前加product$
#1. 請以圖、表或者統計量數說明channel、area，及A之特徵
#2. 請以繪圖方式呈現三者之間關係
ggplot(data=product)+geom_point(aes(x=channel,y=A,color=area))+facet_wrap(~area)

#3. 請求出A的95％信賴區間
#使用T檢定
#因為是單一變數，就是只有一個變數，所以不用判斷變異數
t.test(A,conf.level = 0.95)
#信賴區間:95 percent confidence interval: 10815.29 13185.30

#4. 請檢定A的銷售量是否超過120000，信賴水準95％
t.test(A,mu=120000,alternative = "greater",conf.level = 0.95)
#alternative hypothesis: true mean is greater than 120000 ->這個是在說H1:u>120000
#H0:u<=120000
#H1:u>120000
#p=1>0.05，接受H0，無顯著關係

#5. 請判定A的銷售量是否與B有關
#屬量對屬量 -> 相關(無因果關係)
cor.test(A,B)
#p=0.03506<0.05，有顯著關係，代表有關

#6. 請檢定A的銷售是否影響B的銷售
#屬量對屬量 -> 回歸(有自變數、因變數因果關係)
Easy <-lm(B~A)
anova(Easy)
summary(Easy)
#B=5.865e-02A+5.092e+03(式子)
#影響係數:Multiple R-squared:  0.0101

#7. 請檢定不同的channel，A的銷售是否有差異
#屬質對屬量 ->t檢定(因為channel只有兩個變數)
#要先判斷變異數是否相等
bartlett.test(A~(channel))
#p=2.154e-08<0.05 變異數不相等
t.test(A~channel,alternative='two.sided',var.equal=FALSE)
#p=3.998e-05<0.05，有顯著關係

#8. 請檢定不同的area，A的銷售是否有差異
#屬質對屬量 ->ANOVA(屬質有三種以上)
#需先檢測便異數是否相等
bartlett.test(A~(area))
#p=0.0004971<0.05 變異數不相等
oneway.test(A~factor(area),var.equal = FALSE)
#p=0.1696>0.05，無顯著關係


#9. 請檢定area是否對channel有影響
#屬質對屬質 ->卡方
chisq.test(channel,area)
#p=0.1137>0.05，無顯著關係