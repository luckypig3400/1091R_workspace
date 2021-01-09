install.packages("ggplot2")
library(ggplot2)

# Diamonds # carat：克拉
# cut：切割（Levels: Fair < Good < Very Good <Premium < Ideal）
# color：顏色（Levels: D < E < F < G < H < I < J）
# clarity：純度（Levels: I1 < SI2 < SI1 < VS2 < VS1 < VVS2 < VVS1 < IF）
# depth：深度
# table：檯面
# price：價格

# Diamonds 資料探索
# 單變數-好奇 price, carat, color, clarity的特徵
ggplot(data = diamonds) + geom_histogram(aes(x =
price),fill = "pink", bins = 100) + ggtitle("The Price Of
Diamonds")
ggplot(data = subset(diamonds,price < 2000)) +
geom_histogram(aes(x = price),fill = "pink", bins = 100)
+ ggtitle("The Price Of Diamonds")
ggplot(data = subset(diamonds,price < 2000)) +
geom_histogram(aes(x = price),col=I("skyblue"),fill =
"pink", bins = 100) + ggtitle("The Price Of Diamonds")
ggplot(data = subset(diamonds,price < 2000)) +
geom_histogram(aes(x = price),col=I("skyblue"),fill =
"pink", bins = 100) + ggtitle("The Price Of Diamonds")+
scale_x_continuous(breaks = seq(0,2000,200))

# 單變數- 特徵探索-屬質
ggplot(data =diamonds ) +
geom_bar(aes(x=clarity),fill = "blue")+ ggtitle("The
Clarity Of Diamonds")
ggplot(data = subset(diamonds,price < 2000) ) +
geom_bar(aes(x=clarity),fill = "blue")+ ggtitle("The
Clarity Of Diamonds")

#雙變數--屬質、屬量盒鬚圖分析---- 
ggplot(data=diamonds) + geom_boxplot(aes(x=price,
color=cut))
ggplot(data = subset(diamonds,price < 2000)) +
geom_boxplot(aes(x=price, color=cut))
#為何切割非重要價格影響因素?
ggplot(data=diamonds) + geom_boxplot(aes(x=carat,
color=cut))
ggplot(data = subset(diamonds,price < 2000)) +
geom_boxplot(aes(x=price, color=cut))

##雙變數--5 直方圖
ggplot(data = subset(diamonds,price < 2000)) + geom_histogram(aes(x = price, fill= cut), bins = 100) #切
割好，價差？
ggplot(data = subset(diamonds,price < 2000)) + geom_histogram(aes(x = carat, fill= cut), bins = 100) + scale_x_continuous(breaks = seq(0,20000,4000))
ggplot(data = subset(diamonds,price < 2000)) + geom_histogram(aes(x = price, fill = clarity, bins = 100,scales="free"))
ggplot(data = subset(diamonds,price < 2000)) + geom_histogram(aes(x = carat, fill = clarity, bins = 100,scales="free"))

# #雙變數與多變數- 散布圖看 克拉與價格關係，
以及可能影響變數
ggplot(data=diamonds) + geom_point(aes(x=carat,y=price))
ggplot(data=diamonds) + geom_point(aes(x=carat,y=price, color=clarity))
ggplot(data=diamonds) + geom_point(aes(x=carat,y=price, color=color, shape=cut)) # 雙變數可看出可能關係，加入屬質變數，可更釐清關係—類似中介變數

ggplot(data=diamonds) + geom_point(aes(x=carat,
y=price, color=cut))-價格、克拉及cut-相同克拉，
切割好的價格較高

ggplot(data=diamonds) + geom_point(aes(x=carat,y=price, color=color))
#價格、克拉及color- # color好，克拉較高，color差，克拉較低。
# 相同價格，color好、克拉大

# 透過圖層更清楚解析
ggplot(data = diamonds) + geom_histogram(aes(x =
price,fill=cut,bins=200))+
facet_wrap(~cut,nrow = 3,scales="free_x")+
scale_x_continuous(breaks = seq(0,20000,4000))
#bins:方塊數
# seq(0,20000,4000))，僅到20000，間隔4000

# R繪圖補充
# 外觀相關屬性定義：用aes()定義，常用屬性：x，y，size，color，group
# 資料轉為圖相關屬性，用scale（）定義，常用x，y，alpha，color，fill，linetype，shape，size
# scale_x_continuous()：取連續值
# scale_x_discrete()：取離散值
# scale_x_identity()：使用資料值
# scale_x_mannual()：以離散值為手動值
# scales = “free_x” X軸有自己的座標，scales = "free_y“
# 兩軸都有座標scales = "free“
# 參考資料來源：https://danzhuibing.github.io/R_ggplot2.html#%E6%A0%87%E5%B0%BA
# http://lifesci-murmur.blogspot.com/2017/11/r-ggplot-faceting.html

# #透過圖層發掘可能關係 2色澤 價格
ggplot(data = diamonds) + geom_histogram(aes(x =
price,fill=clarity))+
facet_wrap(~clarity,nrow = 3,scales="free")+
scale_x_continuous(breaks = seq(0,20000,4000))+
ggtitle("The Price Of Diamonds By Clarity")

#透過圖層發掘可能關係 3---- 色澤 價格
ggplot(data = diamonds) + geom_histogram(aes(x =
price,fill=color))+
facet_wrap(~color,nrow = 3,scales="free")+
scale_x_continuous(breaks = seq(0,20000,4000))+
ggtitle("The Price Of Diamonds By Color")

#探討價格與其他變數關係
ggplot(data = diamonds)+
geom_point(aes(x=price,y=depth))
+ scale_x_continuous(breaks = seq(0,15000,2000))+
ggtitle("The Price Vs Depth")
ggplot(data = diamonds)+
geom_point(aes(x=price,y=depth),alpha=1/100)
+ scale_x_continuous(breaks = seq(0,15000,2000))+
ggtitle("The Price Vs Depth")

ggplot(data = diamonds)+
geom_point(aes(x=price,y=x))
+ scale_x_continuous(breaks = seq(0,15000,2000))+
ggtitle("The Price Vs X")

# 鑽石價格影響因素
# 鑽石級別越高，價格越高
# 鑽石的級別與鑽石的4C有關
# 1. 重量：不對鑽石級別有影響，但對鑽石價格會有直接
# 的影響。且對價格影響呈幾何級數增長
# 2. 切工是對小顆粒鑽石級別影響最大的因素
# 3. 凈度：越無暇，價格越高
# 4. 色澤：受切工、大小等影響。D、E、F：屬無色範圍之
# 內，其對應的鑽石級別較高;G、H、I、J
# 原文網址：https://kknews.cc/fashion/6549zrm.html

#探討價格變數關係 5---- 同時加入cut 與 color
ggplot(data = diamonds) 
	+ geom_histogram(aes(x =price,color=cut,fill = cut))
	+facet_wrap(~color,scales="free") 
	+ ggtitle("The PriceOf Diamonds") 
	+ scale_x_continuous(breaks = seq(0,15000,2000))
ggplot(data = diamonds) + geom_histogram(aes(x =
log(price),color=cut,fill = cut))
+facet_wrap(~color,scales="free") +ggtitle("The Price
Of Diamonds")+ scale_x_continuous(breaks =
seq(0,15000,2000))

