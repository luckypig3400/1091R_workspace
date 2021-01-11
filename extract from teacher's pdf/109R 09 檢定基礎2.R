# 統計檢定使用方法：
# 1. 臨界值法—以要估的母數為中心，依據顯著水準
# ，計算出上下限，之後再比較樣本值是否落於此區間。
# 2. 標準統計量法—依據顯著水準找出標準統計量（
# t或Z）之上下限，將樣本資料轉換為標準統計量
# （t或Z），確認是否在此區間內。
# 3. P值法—將樣本資料轉換為標準統計量，並求算
# 出該值之p值（機率）--只要小於顯著水準即代表
# 落於拒絕域。



# 基本指令
# 前置指令：
load("sales_D.RData") #載入資料檔
head(sales_D) #顯示前六筆資料
str(sales_D) #確認各變數的型態
attach(sales_D) #指定之後要使用的資料檔
unique(area) #可確認屬質變數有多少個level
# 估計：
t.test(profit2,conf.level=0.95) #信賴區間估計-profit2變數95％CI



#單一樣本檢定：ex:檢定sales2是否等於14800、大於14800、小於14800
#雙尾檢定
t.test(sales2,mu=14800, conf.level=0.90)
#右尾檢定
t.test(sales2,mu=14800,alternative="greater",
       conf.level=0.95)
#左尾檢定
t.test(sales2,mu=14800,alternative="less",
       conf.level=0.95)



#雙樣本檢定—嚴謹的檢定應先做常態檢定、變異數相等檢定
# 1. t檢定，屬質（自變數）對屬量（因變數）
#先進行常態性與變異數同質性檢定
#常態性檢定
shapiro.test(profit2) # p <0.05代表未吻合常態
hist(profit2, breaks = 40) #直方圖--也是為呈常態分配
#變異數同質檢定
bartlett.test(profit2~(group_p)) # p <0.05代表兩群變異數
# 未相等 t 檢定需在var.equal= 做設定T/F



# 雙尾，變異數不等與相等
t.test(sales2~ group_p,
       alternative='two.sided',var.equal=FALSE)
t.test(profit2~ group_p,
       alternative='two.sided',var.equal=TRUE)
#右尾，變異數相等
t.test(sales2~ group_p, alternative='greater',
       var.equal=TRUE)
#左尾檢定，變異數不等
t.test(sales2~ group_p, alternative=' less ',
       var.equal=FALSE)



#雙樣本檢定—嚴謹的檢定應先做常態檢定、變異數
#相等檢定 2.卡方檢定，屬質（自變數）對屬質（因變數）
#卡方檢定----
table(type,catalogue) #呈現列聯表
chisq.test(type,area)
chisq.test(type,catalogue)
chisq.test(type,city)



# 檢定結果判讀
# One Sample t-test
# data: profit2
# t = 10.732, df = 2878, p-value < 2.2e-16 ----看p值或t值
# alternative hypothesis: true mean is not equal to 0
# 95 percent confidence interval: ------已估出信賴區間
# 1993.539 2884.886
# sample estimates:
#   mean of x
# 2439.213



# 雙樣本檢定—嚴謹的檢定應先做常態檢定、變異數相等檢定
# 3.相關，屬量對屬量 （無因果關係）
# 4.簡單迴歸：屬量對屬量（有自變數、因變數因果關係）
# 3. 相關檢定（無因果關係）
cor.test(profit2, sales2)
# ---------相關結果判讀
# Pearson's product-moment correlation
# data: profit2 and sales2
# t = 19.67, df = 2877, p-value < 2.2e-16 p < 0.05 故有顯著相關
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
# 0.3116888 0.3760999
# sample estimates:
# cor
# 0.3442994 相關係數



# 4. 簡單線性迴歸
lmmodelps<-lm(profit2~sales2)
anova(lmmodelps) #進行總檢定—F檢定，檢定因變數影響是否顯著
summary(lmmodelps) #提供迴歸檢定力相關資訊



summary(lmmodelps)#
# Call:
# lm(formula = profit2 ~ sales2)
# Residuals:
# Min 1Q Median 3Q Max
# -91629 -1498 295 1848 92238
# Coefficients:
# Estimate Std. Error t value Pr(>|t|)
# (Intercept) -3.647e+02 2.567e+02 -1.421 0.155 ＃截距：-364.7，不顯著
# sales2 1.899e-01 9.652e-03 19.670 <2e-16 *** ＃自變數：0.1899，顯著
# Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# ------------- y = -364.7 +0.1899 sales2
# Residual standard error: 11450 on 2877 degrees of freedom
# Multiple R-squared: 0.1185, Adjusted R-squared: 0.1182 ＃影響係數：
# 0.1185
# F-statistic: 386.9 on 1 and 2877 DF, p-value: < 2.2e-16 #模式顯著



#多群樣本檢定--變異數分析- X(屬量) ~ y(屬質)
#先作變異數是否同質之檢定
#Bartlett test p>0.05
bartlett.test(profit2~(area))
#A. 變異數同質
y <- aov(profit2~area,data=sales_D)
anova(y)
#B.變異數不同質
oneway.test(profit2~factor(area),var.equal = FALSE)



# ANOVA結果判讀
# 1.變異數同質檢定
bartlett.test(profit2~(area))
# Bartlett test of homogeneity of variances
# data: profit2 by area
# Bartlett‘s K-squared = 1797.8, df = 3, p-value < 2.2e-16 p < 0.05
# ------- 2.正式ANOVA檢定—視變異數同質檢定結果，採用適當公式
oneway.test(profit2~factor(area),var.equal = FALSE)
oneway.test(profit2~factor(area),var.equal = FALSE)
# One-way analysis of means (not assuming equalvariances)
# data: profit2 and factor(area)
# F = 13.911, num df = 3.0, denom df = 1414.9, p-value = 6.096e09 p < 0.05 ，故群間有顯著差異—需做事後檢定



#-----變異數不同質，事後比較分析
install.packages("DTK")
library(DTK)
posthoc<- with(sales_D, DTK.test(profit2,area))
posthoc
# --------- Diff Lower CI Upper CI
# 北部-中部 1018.4720 -1139.3292 3176.2733
# 東部-中部 -2036.7715 -3582.0784 -491.4646
# 南部-中部 -1127.9004 -2740.2752 484.4744
# 東部-北部 -3055.2436 -4637.5073 -1472.9799
# 南部-北部 -2146.3725 -3794.2649 -498.4800
# 南部-東部 908.8711 241.7613 1575.9809
# -----判讀 上下限CI是否涵蓋0！！東部顯著低於中部與北部



# 變異數同質之事後比較方法，檢定：
y <- aov(profit2~area,data=sales_D)
# 事後比較：
TukeyHSD(y)
plot(TukeyHSD(y))
# ---------- diff lwr upr p adj
# 北部-中部 1018.4720 -661.187 2698.1311 0.4026398
# 東部-中部 -2036.7715 -3877.546 -195.9974 0.0232219
# 南部-中部 -1127.9004 -2807.559 551.7586 0.3101930
# 東部-北部 -3055.2436 -4735.779 -1374.7084 0.0000184
# 南部-北部 -2146.3725 -3648.705 -644.0397 0.0013960
# 南部-東部 908.8711 -771.664 2589.4063 0.5055761
# ---判讀：可看信賴區間，或p值。



# 期中綜合練習
# 1. 請以圖、表或者統計量數說明channel、area，及A之特徵
# 2. 請以繪圖方式呈現三者之間關係
# 3. 請求出A的95％信賴區間
# 4. 請檢定A的銷售量是否超過120000，信賴水準95％
# 5. 請判定A的銷售量是否與B有關
# 6. 請檢定A的銷售是否影響B的銷售
# 7. 請檢定不同的channel，A的銷售是否有差異
# 8. 請檢定不同的area，A的銷售是否有差異
# 9. 請檢定area是否對channel有影響