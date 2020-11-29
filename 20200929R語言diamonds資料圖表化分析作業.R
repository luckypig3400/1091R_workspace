setwd("C:/[Git Repos]/1091R_workspace")#設定工作資料夾
getwd()#取得工作資料夾路徑(get work directory)

install.packages("ggplot2")#安裝ggplot2套件

library(ggplot2)#載入ggplot2套件

head(diamonds) # 撈出diamonds資料表的前6筆資料
tail(diamonds) # 撈出diamonds資料表的末6筆資料  
summary(diamonds) #顯示diamonds資料表的摘要
str(diamonds) # 顯示diamonds資料表的資料結構

ggplot(data = diamonds) + geom_histogram(aes(x =carat,bins= 20)) +facet_wrap(~color)
#散布圖活用 （僅繪Y軸，X軸固定為1）散布圖活用（僅繪Y軸，X軸固定為1）
ggplot(diamonds, aes(y = carat, x = 1)) + geom_point()
ggplot(diamonds, aes(y = carat, x = 1)) + geom_boxplot() #盒鬚圖
ggplot(diamonds, aes(y = carat, x = cut)) + geom_boxplot() #以cut為X軸，繪出不同圖層
ggplot(diamonds, aes(y = carat, x = cut)) + geom_violin() #小提琴圖

ggplot(diamonds, aes(x = carat, y = price, z = clarity)) + geom_point() #小提琴圖
ggplot(diamonds, aes(x = carat, y = price, z = clarity)) + geom_point() #小提琴圖

# 价格和克拉的关系
ggplot(diamonds) + geom_point(aes(x=carat, y=price))
# 加入color和cut的影响
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=color, shape=cut))

# 价格分布
ggplot(diamonds) + geom_histogram(aes(x=price))
# 加入cut的影响
ggplot(diamonds) + geom_histogram(aes(x=price, fill=cut))
# 分组直方图
ggplot(diamonds) + geom_histogram(aes(x=price, fill=cut), position="dodge")
# 百分比直方图
ggplot(diamonds) + geom_histogram(aes(x=price, fill=cut), position="fill")

# 纯净度分布
ggplot(diamonds) + geom_bar(aes(x=clarity))
# 加入color的影响
ggplot(diamonds) + geom_bar(aes(x=clarity, fill=color))

# 价格的概率分布
ggplot(diamonds) + geom_density(aes(x=price))
# 加入cut的影响
ggplot(diamonds) + geom_density(aes(x=price, color=cut))
# 加入color的影响
ggplot(diamonds) + geom_density(aes(x=price, color=color))

# 不同切工下价格的分布
ggplot(diamonds) + geom_boxplot(aes(x=cut, y=price))
# 加入color的影响
ggplot(diamonds) + geom_boxplot(aes(x=cut, y=price, fill=color))

# 坐标变换
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=color, shape=cut)) + scale_y_log10()

# 加上标题和坐标轴标签
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=color, shape=cut)) + scale_y_log10() + labs(x='克拉(Carat)', y='價格(Price)', title='鑽石克拉數與價格之間的關係') + theme(text=element_text(family='Microsoft YaHei'))

# 上面23行以後參考自:https://blog.csdn.net/u013421629/article/details/74085883

# 價格預測可參考此篇:https://zhuanlan.zhihu.com/p/24849496

# ggplot2語法教學
