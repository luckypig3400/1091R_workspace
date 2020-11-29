# 【簡介】

#簡單繪圖：直方圖、散布圖、盒鬚圖

#進階繪圖：ggplot2，區分繪圖資料、座標軸、繪圖函數、圖層－可更精緻繪圖，如:
ggplot(data=sales) + geom_point(aes(x = profit2, y=cost2,color= catalogue))facet_wrap(~area) #aes設定座標軸
#繪圖資料、圖的樣式（註明座標軸、顏色、繪圖點樣式）、圖層，以及統計轉換等
ggplot(data = diamonds) + geom_density(aes(x = carat), fill = "grey50")
#fill：定義顏色

# 【前置工作】
setwd("D:/R_workspace")#設定工作目錄區，雙引號內設定自己所放的資料路徑
getwd() #確認目錄區

# 安裝讀檔相關套件，Rdata不用安裝套件
install.packages("readr")
library(readr)
WHO <- read.csv("WHO.csv")
save(WHO, file = "WHO.RData") #存為RData檔

# 讀入R資料檔
load("WHO.RData") #載入WHO檔
str(WHO)
attach(WHO)

#【基礎繪圖】
#直方圖
hist(GNI, main = "GNI Histogram", xlab = "GNI")
#散布圖
plot(GNI ~ LiteracyRate)
#盒鬚圖單變數
boxplot(GNI) #鬍鬚-- 1.5 IQR-上下限（與傳統統計不同）
boxplot(GNI)$stats #呈現盒鬚圖相關統計值
#盒鬚圖雙變數
boxplot(GNI~Region,las=1)

#【進階繪圖】
install.packages("ggplot2")
library(ggplot2)
str(WHO)
# as.factor(Region) #資料格式轉換-目前轉換與否，不影響
#單變數-可加上顏色--直方圖
ggplot(data = WHO) + geom_histogram(aes(x = GNI))
ggplot(data = WHO) + geom_histogram(aes(x = GNI),fill = "blue")
ggplot(data = WHO) + geom_bar(aes(x=Region)) #無須使用table
ggplot(data = WHO) + geom_bar(aes(x=Region),fill ="pink")
#雙變數boxplot- 屬量對屬質；屬量對屬量
ggplot(data = sales) + geom_bar(aes(x=area, color=type))
ggplot(data=WHO) + geom_boxplot(aes(x = GNI,color=Region))
ggplot(data=WHO) + geom_point(aes(x = GNI, y = LifeExpectancy))
ggplot(data=WHO) + geom_line(aes(x = GNI, y = LifeExpectancy))
ggplot(data=sales) + geom_point(aes(x = date,y=profit2,colour=type))
#有時間的資料，可以看出隨時間變化趨勢
ggplot(data=sales) + geom_line(aes(x = date, y=profit2))

#三個變數兩個屬量搭配一個屬質
ggplot(data=sales, color=Region) + geom_line(aes(x = date,y=profit2 ))
ggplot(data=WHO) + geom_point(aes(x = GNI, y =LifeExpectancy)) #僅兩個變數
ggplot(data=WHO) + geom_point(aes(x = GNI, y =LifeExpectancy, color= Region))
# 利用cloro加入屬質變數
# 加上屬質的變數後，地域變數的特徵應當可以看出！！

ggplot(data=WHO) + geom_point(aes(x = GNI, y = LifeExpectancy))
	+ facet_wrap(~Region)
#透過圖層加第三個變數
ggplot(data=WHO) + geom_point(aes(x = GNI, y = LifeExpectancy,color= Region))
	+ facet_wrap(~Region)
#看出地區差異了嗎

#三個變數一個屬量搭配兩個屬質
load("sales.RData")
str(sales)
ggplot(data=sales) + geom_boxplot(aes(x = profit2, color=type))
ggplot(data=sales) + geom_boxplot(aes(x = profit2, color=type))
	+facet_wrap(~area)
ggplot(data=sales) + geom_point(aes(x = profit2, y=cost2))
	+facet_wrap(~area)
# 利用color加入第四個變數
ggplot(data=sales) + geom_point(aes(x = profit2, y=cost2,
	color=catalogue)) +facet_wrap(~area)

# ggplott 資料、座標軸、圖層外，尚可加入--統計工具
ggplot(data=sales) + geom_point(aes(x = profit2, y=cost2))
	+facet_wrap(~area)
ggplot(data=sales) + geom_point(aes(x = profit2, y=cost2))
	+facet_wrap(~area)+geom_smooth(aes(x = profit2, y=cost2))
ggplot(data=sales) + geom_point(shape = 2, color = "red", aes(x= profit2, y=cost2))
	+facet_wrap(~area)+geom_smooth(aes(x =profit2, y=cost2))
ggplot(data=sales) + geom_point(aes(shape = type, color = type,x = profit2, y=cost2))
	+facet_wrap(~area)+geom_smooth(aes(x= profit2, y=cost2))

# 【ggplot2內建資料檔】
# 利用diamonds資料練習直方圖活用
ggplot(data = diamonds) + geom_histogram(aes(x =carat,bins= 20))
	+facet_wrap(~color)
#散布圖活用（僅繪Y軸，X軸固定為1）散布圖活用
（僅繪Y軸，X軸固定為1）
ggplot(diamonds, aes(y = carat, x = 1)) + geom_point()
ggplot(diamonds, aes(y = carat, x = 1)) + geom_boxplot() #盒鬚圖
ggplot(diamonds, aes(y = carat, x = cut)) + geom_boxplot()
#以cut為X軸，繪出不同圖層
ggplot(diamonds, aes(y = carat, x = cut)) + geom_violin() #小提琴圖

# 【ggplot2詳細介紹】
"""
ggplot2 要件：
– Geometric objects（圖樣）：點、線、散布圖、盒鬚圖、長條圖等
– Aesthetic attributes（美學）：顏色、形狀、大小等
– Facets（圖層）：設定屬質變數為子圖
– Stats：資料做統計轉換，或直接運用統計函數

ggplot2
– 繪圖來源
– 繪圖元件：資料中的變數， aes() 設定變數至X軸與Y 軸
– 外觀呈現：用geom_() 指定繪圖的類型，主要為
#geom_histogram() ：直方圖
#geom_boxplot() ：盒鬚圖
#geom_line() ：線圖
#geom_point() ：散佈圖
#geom_bar() ：長條圖
– 相關運算元素：用+ 加入

#資料來源（data）：
#美學對應（aesthetic）：X、Y座標
#幾何圖案（geometry）：geom，選項有：
	“point”：使用點的方式呈現資料；
	“smooth”：畫出平滑曲線與標準誤差；
	“boxplot”：箱形圖；
	“path”，“line”線段圖；
	“line”；“density”：密度函數圖；
	“bar”，使用adjust 參數調整密度函數圖的平滑程度：長條圖；
	“histogram”直方圖寬度使用binwidth 參數調整， binwidth = 0.01
– 多組資料比較，常用參數fill = color
– 時間序列資料
#使用gplot函數

– path 依據資料順序，將每一個點以線段連接，
path 用在比較兩個變數隨的時間變化的關係。

– line 將點的順序依據x 軸座標來排序。通常line圖形的x 軸是時間的資訊，
用來呈現某個變數隨著時間的變化，而繪圖面（facet）：資料分為不同子圖層輸出

– xlim、ylim：設定x 軸與y 軸的繪圖範圍

#繪圖面（Facet）提供另外一種資料區隔方式，
facets = color ~ cut或facets = color ~ cut
#統計（statistical ）：不同統計函數轉換
#主題（theme）：座標軸、說明文字
#參考資料：https://blog.gtwang.org/r/ggplot2-tutorial-basic-concept-and-qplot/2/
#也可參考此篇:https://ggplot2.tidyverse.org/reference/
"""