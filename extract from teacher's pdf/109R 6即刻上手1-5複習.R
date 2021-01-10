setwd("D:/")#設定路徑
getwd() #確認路徑
install.packages("readxl") #裝可讀xls的套件
library(readxl) #載入可讀xls的套件
tsales <- read_excel("sales sampleR.xlsx")#讀取XLS檔案***請記得檔案要放在所設定的路徑
install.packages("readr") #裝可讀csv的套件
library(readr) ) #載入可讀csv的套件***請記得檔案要放在所設定的路徑
test <- read.csv("WHO.csv",sep = ",",header = TRUE,stringsAsFactors = FALSE))
#讀取csv檔案***請記得檔案要放在所設定的路徑



load("sales.RData") #讀取r的資料檔
save(test,file = "test.RData") 儲存檔案為r可讀檔案
-----------------資料讀入後相關操作
# 觀察有幾個觀測值、幾個變數
dim(sales) # 觀察摘要-簡單敘述統計
summary(sales) # 觀察詳細資訊
str(sales) 
•# 觀察前六個觀測值與後六個觀測值
head(sales) 
tail(sales)



# r探索式分析—繪圖
簡易繪圖
iris＃直接呼叫R內建檔案
#屬質變數-常用長條圖
barplot(table(iris$Species))
#屬量變數-常用直方圖、盒鬚圖
hist(iris$Sepal.Length)
boxplot(iris$Sepal.Length)
#探索關係—兩個以上變數
#兩個屬量變數-散布圖
plot(iris$Sepal.Length,iris$Sepal.Width)
#一個屬量一個屬質-盒鬚圖
boxplot(iris$Sepal.Length~iris$Species)



繪圖相關設定
par(mfrow=c(1,2), cex=0.6, las=2) # mfrow=c(1,2):一列有2張圖；cex=0.6:字體大小；las:控制X軸Y
軸文字的方向，有0~3可以選，常用2
xlab, ylab：x,y軸標籤，main圖標題；col:顏色選擇, labels=labs,
init.angle=90
abline(v=10000, h=2.5, col="pink")劃出基準線，設定垂直與水平
線的高度
attach(test) #連續使用某檔案
par(mfrow=c(1,1), cex=0.5, las=1) #調整畫布格式
hist(iris$Sepal.Length, breaks = 30) #直方圖有30個
區隔



簡單繪圖：直方圖、散布圖、盒鬚圖
進階繪圖-ggplot2，區分繪圖資料、座標軸、繪圖
函數、圖層－可更精緻繪圖
– 如：ggplot(data=sales) + geom_point(aes(x =
profit2, y=cost2,color= catalogue))
+facet_wrap(~area) #aes設定座標軸
– ggplot(data = diamonds) + geom_density(aes(x =
carat), fill = “grey50”) #fill：定義顏色、繪圖資
料、圖的樣式（註明座標軸、顏色、繪圖點樣
式）、圖層，以及統計轉換等，寬度使用 bins
參數調整
要多練習



-ggplot2內建資料檔
利用 diamonds資料練習直方圖活用
需安裝ggplot2套件
install.packages("ggplot2")
library(ggplot2)
ggplot(data = diamonds) + geom_histogram(aes(x =
carat,bins= 20)) #一個屬量變數-直方圖
ggplot(data = diamonds) + geom_bar(aes(x=clarity)) #一個
屬質變數-長條圖



#兩個變數-一個屬質一個屬量
ggplot(data = diamonds) + geom_histogram(aes(x =
carat,bins= 20)) +facet_wrap(~color)
ggplot(data = diamonds) + geom_histogram(aes(x =
carat,bins= 20,fill=color)) +facet_wrap(~color)
#兩個變數-兩個屬質
ggplot(data = diamonds) + geom_histogram(aes(x =
carat,bins= 20,fill = color))
ggplot(data = diamonds) + geom_histogram(aes(x =
carat,bins= 20,color = color))



Diamonds 資料探索
單變數-好奇 price, carat, color, clarity的特徵
ggplot(data = diamonds) + geom_histogram(aes(x = price),fill
= "pink", bins = 100) + ggtitle("The Price Of Diamonds")
ggplot(data = subset(diamonds,price < 2000)) +
geom_histogram(aes(x = price),fill = "pink", bins = 100) +
ggtitle("The Price Of Diamonds")
ggplot(data = subset(diamonds,price < 2000)) +
geom_histogram(aes(x = price),col=I("skyblue"),fill = "pink",
bins = 100) + ggtitle("The Price Of Diamonds")
ggplot(data = subset(diamonds,price < 2000)) +
geom_histogram(aes(x = price),col=I("skyblue"),fill = "pink",
bins = 100) + ggtitle("The Price Of Diamonds")+
scale_x_continuous(breaks = seq(0,2000,200))



#雙變數--屬質、屬量盒鬚圖分析---- ggplot(data=diamonds) + geom_boxplot(aes(x=price,
color=cut))
ggplot(data = subset(diamonds,price < 2000)) +
geom_boxplot(aes(x=price, color=cut))
#為何切割非重要價格影響因素?
ggplot(data=diamonds) + geom_boxplot(aes(x=carat,
color=cut))
ggplot(data = subset(diamonds,price < 2000)) +
geom_boxplot(aes(x=price, color=cut))



#雙變數與多變數- 散布圖看 克拉與價格關係，
以及可能影響變數
ggplot(data=diamonds) + geom_point(aes(x=carat,
y=price)) ggplot(data=diamonds) + geom_point(aes(x=carat,
y=price, color=clarity)) ggplot(data=diamonds) + geom_point(aes(x=carat,
y=price, color=color, shape=cut)) 雙變數可看出可能關係，加入屬質變數，可更釐
清關係—類似中介變數



散布圖—看兩個至多個變數關係價格與克拉有正
向關係
ggplot(data=diamonds) + geom_point(aes(x=carat,
y=price, color=cut))
#價格、克拉及cut-相同克拉，切割好的價格較高
ggplot(data=diamonds) + geom_point(aes(x=carat,
y=price, color=color))
#價格、克拉及color- color好，克拉較高，color差
，克拉較低



ggplot(data = diamonds) + geom_histogram(aes(x =
price,fill=cut,bins=200))+
facet_wrap(~cut,nrow = 3,scales="free_x")+
scale_x_continuous(breaks = seq(0,20000,4000))



dplyr套件練習--使用gdpminder資料集
install.packages("gapminder")
library(gapminder)
install.packages("dplyr")
library(dplyr)
structure()：瞭解各欄位資料型態
– unique(gapminder$country) #查看國家欄位有哪
些獨立資料值
– filter 使用
filter(gapminder, country == "Taiwan") %>% View() 參考: 郭耀仁 網路資料



select() 使用
– gapminder %>% select(country, continent)
arrange() 資料排序
– gapminder %>% arrange(pop)
mutate() 新增變數
– gapminder %>% mutate(pop_in_thousands = pop /
1000)
summarise() 使用
– gapminder %>% filter(year == 2007) %>%
summarise(sum(as.numeric(pop)))
group_by()
gapminder %>% group_by(year) %>%
summarise(sum(as.numeric(pop)))



filter(gapminder, country == "Taiwan") %>%
View() #國家欄為台灣的資料
gapminder %>%
filter(country %in% c("Taiwan", "Japan")) %>% # A %in% B
：A 是否在B 中
View()
# select() 選出符合條件欄位
gapminder %>% select(country, continent)%>% View()
# arrange() 資料排序
gapminder %>% arrange(pop)
# summarise() 挑選符合年度為2007，並將pop轉為數值後求
出彙總值
gapminder %>% filter(year == 2007) %>%
summarise(sum(as.numeric(pop)))



#想瞭解各年度的人口值
# group_by() 以年度合併資料，並求出pop彙總值
gapminder %>% group_by(year) %>%
summarise(sum(as.numeric(pop))) %>%
View()
gap_year <- gapminder %>% group_by(year) %>%
summarise(sum(as.numeric(pop)))
names(gap_year) <- c("year","sum_pop")
gap_year



#dplyr 與ggplot2結合
install.packages("ggplot2")
library(ggplot2)
#畫出各年度的彙總值
ggplot(gap_year)+ geom_point(aes(x = year, y = sum_pop))
ggplot(gap_year)+ geom_point(aes(x = year, y =
sum_pop,size=sum_pop))
#挑出某年度資料，比較五大洲各國的pop與lifeExp及
gdpPercap的關係
str(gapminder)



#1.先挑出年度
gapminder_1952 <- gapminder %>%
filter(year == 1952)
#2以某年度資料為基礎，開始畫圖
ggplot(gapminder_1952) + geom_point(aes(x = pop, y = lifeExp,
color = continent, size = gdpPercap),scales="free_x")
ggplot(gapminder_1952) + geom_point(aes(x = pop, y = lifeExp,
color = continent, size = gdpPercap),scales="free_x") +
scale_x_log10()
ggplot(gapminder_1952) + geom_point(aes(x = pop, y =
gdpPercap, color = continent, size = gdpPercap),scales="free_x")
+
scale_x_log10()



#3透過圖找出一個有趣的問題--到底是哪些國家-- ggplot(gapminder_1952) + geom_point(aes(x = pop, y =
gdpPercap, color = continent, size = gdpPercap),scales="free_x")
+ scale_x_log10()+ scale_y_log10()