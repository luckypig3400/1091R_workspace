# dylyr 套件
# 使用時機：針對資料作篩選、新增、排序、分類統計與統計等功能。
# 使用管線運算子%>%，需先安裝 dplyr，運作的概：使輸入%>%輸出
install.packages("dplyr")
library(dplyr)
x <- 1200
x %>% log %>% sqrt %>% mean # 結果等同下式
mean(sqrt(log(x)))
1:15 %>% sum()



# dplyr套件的主要應用
# filter() ：挑選符合條件資料，列挑選，可設：聯集&，交集：|
# select()：篩選變數，欄挑選
# mutate() ：新增變數，可計算後新增變數，如：mutate(某資料, 某欄位 = 某欄位 / 10000)
# arrange()：排序-由小到大，如果要由大到小--desc()
# group_by ：資料分類別處理
# summarise ：快速找出變數的資料特徵值



# dplyr套件練習--使用gdpminder資料集
install.packages("gapminder")
library(gapminder)
# colname(): 瞭解重要資料欄位：country （國家）、 continent （洲）、year （年）
#lifeExp(預期平均壽命）、pop（人口數）、“gdpPercap (人均 GDP)”
# structure()：瞭解各欄位資料型態
# unique(gapminder$country) #查看國家欄位有哪些獨立資料值
# filter 使用
# filter(gapminder, country == "Taiwan") %>% View()
# 參考: 郭耀仁 網路資料
# select() 使用
# gapminder %>% select(country, continent)
# arrange() 資料排序
# gapminder %>% arrange(pop)
# mutate() 新增變數
# gapminder %>% mutate(pop_in_thousands = pop / 1000)
# summarise() 使用
# gapminder %>% filter(year == 2007) %>%summarise(sum(as.numeric(pop)))
# group_by()
# gapminder %>% group_by(year) %>%summarise(sum(as.numeric(pop)))#以年度彙總，算出pop會總值



filter(gapminder, country == "Taiwan") %>%
View() #國家欄為台灣的資料
gapminder %>%
filter(country %in% c("Taiwan", "Japan")) %>%View()
# A %in% B：A 是否在B 中
# select() 選出符合條件欄位
gapminder %>% select(country, continent)%>% View()
# arrange() 資料排序
gapminder %>% arrange(pop)
# summarise() 挑選符合年度為2007，並將pop轉為數值後求
出彙總值
gapminder %>% filter(year == 2007) %>%
summarise(sum(as.numeric(pop)))



#想瞭解各年度的人口值
# group_by() 以年度合併資料，並求出pop彙總值
gapminder %>% group_by(year) %>%
summarise(sum(as.numeric(pop))) %>%
View()
gap_year <- gapminder %>% group_by(year) %>%
summarise(sum(as.numeric(pop))) #將彙總值存至gap_year
names(gap_year) <- c(" year ", " sum_pop ") #更改欄位名稱
gap_year#顯示結果



#dplyr 與ggplot2結合
install.packages("ggplot2")
library(ggplot2)
#畫出各年度的彙總值
ggplot(gap_year)+ geom_point(aes(x = year, y = sum_pop))
ggplot(gap_year)+ geom_point(aes(x = year, y =
sum_pop,size=sum_pop))
#挑出某年度資料，比較五大洲各國的pop與lifeExp及
gdpPercap的關係
str(gapminder)



#1.先挑出年度
gapminder_1952 <- gapminder %>%
filter(year == 1952)
#2以某年度資料為基礎，開始畫圖
ggplot(gapminder_1952) + geom_point(aes(x = pop, y = lifeExp,
color = continent, size = gdpPercap),scales="free_x")
ggplot(gapminder_1952) + geom_point(aes(x = pop, y = lifeExp,
color = continent, size = gdpPercap),scales="free_x") +
scale_x_log10()
ggplot(gapminder_1952) + geom_point(aes(x = pop, y =
gdpPercap, color = continent, size = gdpPercap),scales="free_x")
+ scale_x_log10()



#3透過圖找出一個有趣的問題--到底是哪些國家--
ggplot(gapminder_1952) + geom_point(aes(x = pop, y =
gdpPercap, color = continent, size = gdpPercap),scales="free_x")
+ scale_x_log10()+ scale_y_log10()



#練習1--希望找出這些國家-請告訴我這是哪些國家
#使用sales檔案練習
sales %>% dim()
str(sales)
unique(sales$city)
unique(sales$area)
# summarise() 挑選符合地域為北部，並將profit2轉為數值
後求出彙總值
sales %>% filter(area == "北部") %>%
summarise(sum(as.numeric(profit2)))
# group_by() 以地域合併資料，並求出profit2彙總值
sales %>% group_by(area) %>%
summarise(sum(as.numeric(profit2)))
boxplot(profit2~area, data = sales)—事實上關係還是看的不
很清楚



#練習2--請練習用sales檔案
思考：如果你有sales檔案，你期待找出哪些關係
，可以對你的經營決策有幫助---可能成為期中作
業
#練習21--北部地區哪幾個城市利潤最高
#練習22--北部地區-豪華型，哪個城市利潤最高
#練習23--北部地區-哪種類別產品利潤最高
