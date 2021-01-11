# 統計檢定使用方法：
# 1. 臨界值法—以要估的母數為中心，依據顯著水準
# ，計算出上下限，之後再比較樣本值是否落於此區間。
# 2. 標準統計量法—依據顯著水準找出標準統計量（
# t或Z）之上下限，將樣本資料轉換為標準統計量
# （t或Z），確認是否在此區間內。
# 3. P值法—將樣本資料轉換為標準統計量，並求算
# 出該值之p值（機率）--只要小於顯著水準即代表落於拒絕域。



unique(area) #可確認屬質變數有多少個level
#估計—可估90、95、99%......信賴區間
t.test(profit2,conf.level=0.95) #信賴區間估計-profit2變數95％
# CI
# 功用: 利潤有高有低，可以設定一個區間，在此區間內，或
# 許可以不用太擔心
# One Sample t-test
# data: profit2
# t = 10.732, df = 2878, p-value < 2.2e-16 ----看p值或t值
# alternative hypothesis: true mean is not equal to 0
# 95 percent confidence interval: ------已估出信賴區間
# 1993.539 2884.886
# sample estimates:
#   mean of x
# 2439.213



##單一樣本檢定 sales2是否等於14800、大於14800、小於14800mean(sales2)
t.test(sales2,mu=14800, conf.level=0.95) #雙尾檢定
# One Sample t-test
# data: sales2
# t = -0.077696, df = 2878, p-value = 0.9381 ----檢定結果看p或t值—是否顯住水準
# alternative hypothesis: true mean is not equal to 14800 ---檢定的條件
# 95 percent confidence interval:
#   13959.79 15576.16
# sample estimates:
#   mean of x
# 14767.98



t.test(sales2,mu=14800, conf.level=0.90) #雙尾檢定
data: sales2
# t = -0.077696, df = 2878, p-value = 0.9381---樣本資料相同，故p或t值相同
# alternative hypothesis: true mean is not equal to 14800
# 90 percent confidence interval:
#   14089.80 15446.16 --- 信賴區間比較小
# sample estimates:
#   mean of x
# 14767.98



t.test(sales2,mu=14800,alternative="greater", conf.level=0.95) #右尾檢定
data: sales2
# t = -0.077696, df = 2878, p-value = 0.531—看p或t值-與1.645、1.96、2.545
# 比較。p似乎有計算錯誤
# alternative hypothesis: true mean is greater than 14800
# 95 percent confidence interval:
#   14089.8 Inf --右尾檢定區間
# sample estimates:
#   mean of x
# 14767.98 



t.test(sales2,mu=14800,alternative="less", conf.level=0.95) #左尾檢定
data: sales2
# t = -0.077696, df = 2878, p-value = 0.469看p或t值。p似乎有計算錯誤
# alternative hypothesis: true mean is less than 14800
# 95 percent confidence interval: -Inf 15446.16 ----左尾檢定之區間
# sample estimates:
#   mean of x
# 14767.98



#練習
#diamonds檔案，那些變數可以作檢定
#請估計price的90%信賴區間
#請檢定X是否等於5.7，是否大於5.8、是否小於5.74
--------------- #雙樣本檢定---哪些可以作雙樣本檢定?
  #先進行常態性與變異數同質性檢定
  #常態性檢定



shapiro.test(sales2) #學術上應檢測，實務上多數略過Shapiro-Wilk normality test
data: sales2
# W = 0.65078, p-value < 2.2e-16 --p小於0.05－顯示未符合常態分配



變異數同質性檢定
var.test(A群資料, B群資料) #進行變異數同質檢定—本次資料無法檢定雙樣本雙尾檢定
t.test(sales2~ group_p, alternative='two.sided',var.equal=T) ))
#因變數～自變數，檢定型態，變異數是否相等
t.test(sales2~ group_p, alternative=‘two.sided’,var.equal=F #不等
       # --- H0：A群平均數＝B群平均數
       # Two Sample t-test data: sales2 by group_p
       # t = -0.65579, df = 2877, p-value = 0.512 --檢定結果 p >0.05，在接受域—無顯
       # 著差異
       # alternative hypothesis: true difference in means is not equal to 0
       # 95 percent confidence interval: -2203.134 1098.797
       # sample estimates:
       #   mean in group L mean in group H
       # 14435.79 14987.96



t.test(profit2~ group_p, alternative='two.sided',var.equal=TRUE)
# Two Sample t-test
# data: profit2 by group_p
# t = -26.687, df = 2877, p-value < 2.2e-16 ---- p <0.05，且t值相
# 當大，故兩群profit2有顯著差異
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#  -11909.91 -10279.57
# sample estimates:
# mean in group L mean in group H
# -4235.358 6859.381



#右尾
t.test(tj_pop$lifeExp~ tj_pop$country,
       alternative='greater', var.equal=TRUE)
#左尾
t.test(tj_pop$lifeExp~ tj_pop$country, alternative='less',
       var.equal=TRUE)



# 統計估計
# 統計估計是利用樣本統計量去推估母體參數的方法。
# – 點估計(point estimation)：根據樣本資料求得一估計值，
# 以推估未知的母體參數。
# – 區間估計(interval estimation)：根據樣本資料所求出的
# 點估計值(point estimate)，藉由點估計量抽樣分配的性
# 質求出兩個數值而構成一區間，稱為區間估計值
# (interval estimate)，並利用此一區間推估未知母體參數的範圍。



#練習
#diamonds檔案，那些變數可以作檢定
#請估計price的90%信賴區間
#請檢定X是否等於5.7，是否大於5.8、是否小於5.74



# 雙樣本檢定練習
# 雙樣本檢定練習--取出兩群資料，比較某平均數值是否相等---- #先安裝gapminder及dplyr套件
install.packages("dplyr")
install.packages("gapminder")
library(gapminder)
library(dplyr)
# 將gapminder資料中，國家為Taiwan及Japan的資料挑出
# 並放入變數tj_pop-有24個資料值
tj_pop<- gapminder %>% filter(country %in% c("Taiwan", "Japan"))
tj_pop



#雙樣本檢定
#先進行常態性與變異數同質性檢定
t_pop<- tj_pop %>% filter(country %in% c("Taiwan")) #將tj_pop資料中，國家為Taiwan的資料挑出
j_pop<- tj_pop %>% filter(country %in% c("Japan")) #將tj_pop資料中，國家為Japan的資料挑出
t_pop<- as.vector(t_pop) #轉換資料型態為向量
j_pop<- as.vector(j_pop)
#常態性檢定
shapiro.test(j_pop$lifeExp)
shapiro.test(t_pop$lifeExp)
var.test(t_pop$lifeExp,j_pop$lifeExp) #進行變異數同質檢定
#雙尾
t.test(tj_pop$lifeExp~ tj_pop$country,
       alternative='two.sided',var.equal=TRUE)



# 變異數同質性檢定
var.test(t_pop$lifeExp,j_pop$lifeExp) #進行變異數同質檢定
#----
# F test to compare two variances
# data: t_pop$lifeExp and j_pop$lifeExp
# F = 0.86214, num df = 11, denom df = 11, p-value = 0.81 p>0.05，故兩群資料變異數相等
# alternative hypothesis: true ratio of variances is not equal to 1
# 95 percent confidence interval:
#   0.2481896 2.9948011
# sample estimates:
#   ratio of variances
# 0.862136



#雙尾
t.test(tj_pop$lifeExp~ tj_pop$country,
       alternative=‘two.sided’,var.equal=T) #檢定日本、台灣兩國的lifeExp是否相等
# --------- Two Sample t-test
# data: tj_pop$lifeExp by tj_pop$country
# t = 1.7551, df = 22, p-value = 0.09316----p大於0.05，故無顯著差異
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -0.8155591 9.7960591
# sample estimates:
#   mean in group Japan mean in group Taiwan
# 74.82692 70.33667 



#卡方檢定----檢定兩屬質變數是否有差異
chisq.test(type,area)
chisq.test(type,catalogue)
chisq.test(type,city)
#屬於獨立性檢定—
H0：各地區所販售的產品型態無顯著差異



table(type,catalogue)#可先製作列聯表看是否有顯著差異，之後進行檢定
# ---------- Pearson's Chi-squared test
# data: type and city
# X-squared = 0.0062761, df = 18, p-value = 1---檢定結
# 果—無顯著差異
# 
# 
# 
# 練習：利用diamond檔案，看
# – cut與clarity是否有顯著差異
# – cut與color是否有顯著差異
# – color與clarity是否有顯著差異