setwd("D:/+109rtemp")
getwd()

install.packages(readxl) #若尚未安裝套件先需安裝
library(readxl) #導入套件readxl
sales <- read_excel("sales sampleR.xlsx")

#-------
# 觀察有幾個觀測值、幾個變數
dim(sales)

# 觀察摘要-簡單敘述統計
summary(sales)

# 觀察詳細資訊
str(sales)

# 觀察前六個觀測值與後六個觀測值
head(sales)
tail(sales) 

# 探索 sales 變數的分佈-單一變數
# hist() 直方圖探索數值變數
hist(sales$sales2)
#barplot() 函數繪製長條圖來探索類別的頻率-需結合table:計算出次數
barplot(table(sales$type))
# 分類對比
# boxplot() 函數繪製盒鬚圖來探索不同類別與數值分佈的關係
boxplot(sales2~ type, data=sales)
boxplot(sales2~ area, data=sales)
boxplot(sales2~ catalogue, data=sales)
boxplot(sales2~ city, data=sales)

hist(sales$sales, main = "Sales Histogram", xlab = "Sales")
plot(cost~ profit, data = sales)
plot(diamonds$carat, diamonds$price)
boxplot(profit2~city, data = sales,las=1)
boxplot(profit2~area, data = sales,las=1)
install.packages("ggplot2")
require(ggplot2)
ggplot(data = sales) + geom_histogram(aes(x = profit2))
ggplot(data = sales) + geom_histogram(aes(x = profit2,fill=
city)) +facet_wrap(~city)

#使用管線套件
install.packages("dplyr")
library(dplyr)
sales %>% dim()
str(sales)
unique(sales$city)
unique(sales$area)
# summarise() 挑選符合地域為北部，並將profit2轉為數值
後求出彙總值
sales %>% filter(area == "北部") %>%
summarise(sum(as.numeric(profit2)))

# group_by() 以地域合併資料，並求出profit2彙總值
sales %>% group_by(area) %>%
summarise(sum(as.numeric(profit2))) boxplot(profit2~area, data = sales)


