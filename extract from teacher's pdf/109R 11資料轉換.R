# 資料重編碼
# – 當屬質資料（自變數）有3類以上，應當用變異數分析
# ，某幾類個數偏低，可以轉為2類，改用t檢定
# – 卡方檢定：每個cell小於5的觀察個數不可過多
# – 屬質轉屬質—將五等級降為兩等級
# – 使用ggplot2的diamonds檔案，將cut由5等級轉為2等級
install.packages("ggplot2")
library(ggplot2)
str(diamonds)
diamonds$cut_r <-
  recode(diamonds$cut,'Ideal'='A','Premium'='A','Very
Good'='B' ,'Good'='B','Fair'='B')



#屬量轉屬質---- • 如價格由325～18823，屬量資料，以中位數為切割點，切
為高價與低價
str(diamonds)
summary(diamonds$price)
#極大18823，極小326
cutpoint<-c(323,2401,18825)
#極大值及極小值需往兩側延伸，方能順利將資料涵蓋
diamonds$price_R<-cut(diamonds$price,cutpoint,c("L","H"))
factor(diamonds$price_R)
str(diamonds)



#屬量轉屬量—延續上例，中位數為分割點，中位數之前改為1、中位數之後改為2
max(price)
min(price)
median(price)
quantile(diamonds$price,0.33)
cutpoint<-c(326,2401,18823)
cutvalue<-c(1,2)
diamonds$price_R<-cut(diamonds$price,cutvalue)



# 練習
# 資料字串:73 87 75 86 44 16 31 48 67 91 4 14 65 1 34 40 33 97 15 78
# 將年齡資料轉換為年齡群組1~20, 21~40, 41~60, 61歲以上，並編碼為A, B, C, D
test<-
  c(73,87,75,86,44,16,31,48,67,91,4,14,65,1,34,40,33,97,
    15,78)
cutpoint <- c(0,20,40,60,100)