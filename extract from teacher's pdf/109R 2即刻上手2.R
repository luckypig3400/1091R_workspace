setwd("D:/R_workspace")
#設定工作目錄區，"/"引號內設定自己所放的資料路徑
getwd() #確認目錄區


#========================================#
#【讀檔】

#讀xls
install.packages("readxl") #安裝可讀xls的套件
library(readxl) #載入可讀xls的套件
saleXlsx <- read_excel("sales sampleR.xlsx")
#讀取XLS檔案，並放入變數tsale
View(saleXlsx)# 查看檔案 注意V要大寫

#讀csv
install.packages("readr") #安裝可讀csv的套件
library(readr) #載入可讀xls的套件
testCSV <- read.csv("WHO.csv",sep = ",",header = TRUE,stringsAsFactors = FALSE)
View(testCSV)

#讀json
install.packages("rjson")
library(rjson)
#========================================#

#【存檔】(R 資料檔格式.Rdata)
save(testCSV,file = "test.RData") #存成R的格式檔案
write.csv(saleXlsx, file = "testOutCSV.csv") #存成csv的格式檔案

#========================================#
# 【解析資料】
#讀入資料- #利用之前讀入的test檔案-WHO檔案
head(test)
#資料總覽Data Summary
str(test)#查看檔案資料結構$--某檔案的欄位變數
head(test)#前六筆資料
mean(test$Under15)#某變數平均數
sd(test$Under15)#標準差
summary(test$Under15)#彙總性統計-屬量資料方能用

which.min(test$Under15)#15歲以下人口比率最低的國家

which.max(test$Under15)#15歲以下人口比率最高的國家

#資料視覺化
#透過直方圖、長條圖、散布圖、盒鬚圖等看出資料特徵
#http://yijutseng.github.io/DataScienceRBook/vis.html#資料視覺化的目的

#========================================#
# 【繪圖】
# 常用繪圖控制參數—參考
par(mfrow=c(1,2), cex=0.6, las=2)
# mfrow=c(1,2):一列有2張圖；cex=0.6:字體大小；las:控制X軸Y軸文字的方向，有0~3可以選，常用2
# xlab, ylab：x,y軸標籤；main:圖標題；col:顏色選擇, labels=labs；init.angle=90
abline(v=10000, h=2.5, col="pink")
# 劃出基準線，設定垂直與水平線的高度

# 直方圖-看出屬量（數值變數）單變數的特徵
#看出資料的平均值與離散程度
hist(test$CellularSubscribers)#屬量資料
attach(test) #連續使用某檔案
hist(CellularSubscribers, breaks = 20) #20個區隔
mean(test$CellularSubscribers)
mean(test$CellularSubscribers, na.rm = T)#移除遺漏值
# 屬質變數-單變數
#barplot() 函數繪製長條圖來探索類別的頻率-需結合table:計算出次數
attach(test) #連續使用test檔案
barplot(table(Region), las=2)
par(mfrow=c(1,1), cex=0.5, las=1) #調整畫布格式
barplot(table(Region))

# 散布圖
#查找兩變數可能關連
#散布圖Scatterplot -屬量對屬量查看兩個屬量變數的關連
#查看GNI與Under15，及CellularSubscribers是否有關連
#用plot函數有時關係看不出，資料可以再切割-分組—要資料合併、清理-dplyr套件
par(mfrow=c(1,1), cex=0.6, las=1)
plot(test$Under15, test$GNI)
plot(test$GNI, test$CellularSubscribers)

#盒狀圖Boxplot #需有屬質搭配屬量變數
boxplot(test$CellularSubscribers ~ test$Region, las=3)
boxplot(test$CellularSubscribers ~ test$Region,
	xlab = "", ylab = "CellularSubscribers",
	main = "CellularSubscribers of Countries by Region")



# 練習以sales sampleR.xlsx看看是否能透過圖形方式找出一些趨勢？