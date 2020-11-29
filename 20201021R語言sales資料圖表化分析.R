#基本路徑設定、讀檔與相關套件安裝
setwd("D:/R_workspace/")
getwd()
load("sales.RData")
str(sales)
#安裝相關套件
pkgs <- c("ggplot2", "dplyr")
install.packages(pkgs)
library(dplyr) #載入管線操作函式庫
library(ggplot2) #載入ggplot2繪圖函式庫
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

ggplot(data = sales) + geom_histogram(aes(x = profit2,fill = area))
ggplot(data = sales) + geom_histogram(aes(x = profit2,fill = area))+ scale_y_log10()
ggplot(data = sales) + geom_histogram(aes(x = profit2,fill = area))+ scale_y_log10() + scale_x_log10()
ggplot(data = sales) + geom_histogram(aes(x = profit2,fill = type))+ scale_y_log10()
ggplot(data = sales) + geom_histogram(aes(x = profit2,fill = catalogue))+ scale_y_log10()
ggplot(data = sales) + geom_histogram(aes(x = profit2,fill = catalogue))+ scale_y_log10()+ scale_x_log10()



# 練習1--北中南東各地利潤--group_by() 以地區合併資料，並求出profit2彙總值---
sales_a <- sales %>% group_by(area) %>% summarise(sum(as.numeric(profit2)))
sales_a 

colnames(sales_a) <- c("area","profit") #重新命名資料表欄位
boxplot(sales_a$profit~sales_a$area) #使用預設繪圖函式繪圖
ggplot(data = sales_a) + geom_boxplot(aes(x=area,y=profit),scales="free_x") + scale_y_log10() #使用ggplot繪圖函式繪圖



#練習2---3大類(type)產品利潤高低
sales_3typeProduct <- sales %>% group_by(type) %>% summarise(sum(as.numeric(profit2)))
sales_3typeProduct # 這個時候查看資料欄位會發現有一欄叫做`sum(as.numeric(profit2))`

colnames(sales_3typeProduct) <- c("type","profit")#重新命名資料表欄位
sales_3typeProduct # 再次查看資料表會發現資料欄位名稱變成type與profit

ggplot(data = sales_3typeProduct) + geom_boxplot(aes(x=type,y=profit),scales="free_x") + scale_y_log10() #使用ggplot繪圖函式繪圖



#練習3---各地區3大類(type)產品的利潤高低
sales_eachArea_3typeProduct <- sales %>% group_by(area,type) %>% summarise(sum(as.numeric(profit2)))
sales_eachArea_3typeProduct # 這個時候查看資料欄位會發現有一欄叫做`sum(as.numeric(profit2))`

colnames(sales_eachArea_3typeProduct) <- c("area","type","profit")#重新命名資料表欄位
sales_eachArea_3typeProduct # 再次查看資料表會發現資料欄位名稱分別變成area、type與profit

ggplot(data = sales_eachArea_3typeProduct) + geom_boxplot(aes(x=area, y=profit))
# 加入color的影響
ggplot(data = sales_eachArea_3typeProduct) + geom_point(aes(x=area, y=profit, color=type))
# 加上標題和座標軸標籤
ggplot(data = sales_eachArea_3typeProduct) + geom_point(aes(x=area, y=profit, color=type)) + scale_y_log10() + labs(x='區域(area)', y='利潤(Profit)', title='各區域之商品類型與利潤之間的關係') + theme(text=element_text(family='Microsoft YaHei'))
