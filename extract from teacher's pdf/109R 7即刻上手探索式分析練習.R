#基本路徑設定、讀檔與相關套件安裝
getwd()
setwd("D:/+109rtemp/")
load("sales.RData")
str(sales)
#安裝相關套件
pkgs <- c("ggplot2", "dplyr")
install.packages(pkgs)
library(dplyr) #管線操作軟體
library(ggplot2)
str(sales)



#這組數具有何特徵
attach(sales)
table(type)
table(catalogue)
table(area)
table(city)
unique(catalogue)
table(type,catalogue)
summary(profit2)
summary(sales2)



ggplot(data = sales) + geom_histogram(aes(x =
                                            profit2,fill = area))
ggplot(data = sales) + geom_histogram(aes(x =
                                            profit2,fill = area))+ scale_y_log10()
ggplot(data = sales) + geom_histogram(aes(x =
                                            profit2,fill = area))+ scale_y_log10()+scale_x_log10()
ggplot(data = sales) + geom_histogram(aes(x =
                                            profit2,fill = type))+ scale_y_log10()
ggplot(data = sales) + geom_histogram(aes(x =
                                            profit2,fill = catalogue))+ scale_y_log10()
ggplot(data = sales) + geom_histogram(aes(x =
                                            profit2,fill = catalogue))+
  scale_y_log10()+scale_x_log10()



# 練習1--北、中、南等各地利潤何者較高
#練習2---3大產品利潤高低
#練習3---各地區3大產品的利潤高低
#練習4--北部地區哪幾個城市利潤最高
#練習5--各年度北部地區哪幾個城市利潤最高


