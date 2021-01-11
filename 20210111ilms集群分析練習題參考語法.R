#練習1----畫圖找各群特徵

install.packages("ggplot2")
library(ggplot2)
ggplot(data=res.hcpc$data.clust) + geom_point(aes(x = Murder, y = UrbanPop, color= clust)) 

ggplot(data=res.hcpc$data.clust) + geom_point(aes(x = Murder, y = UrbanPop)) +
 facet_wrap(~clust)

#練習2 連續變數
getwd()
wholes <- read.csv("wholesales.csv")
str(wholes)
head(wholes)
#1.資料矩陣操作
wh <- wholes[,c(2,6:8)]
str(wh)
#2.主成分分析
res.pca_w <- PCA(wholes, ncp = 2, graph = FALSE)
plot(res.pca_w, choix = "ind")
plot(res.pca_w, choix = "var")
# 3.HCPC 分析
res.hcpc_w <- HCPC(res.pca_w, graph = FALSE)
# 3A樹狀圖 factoextra 的 fviz_dend 繪製由階層式分群所產生的樹狀圖
fviz_dend(res.hcpc_w,
          cex = 0.7,                     # 文字大小
          palette = "jco",               # 文字配色（可參考 ?ggpubr::ggpar）
          rect = TRUE, rect_fill = TRUE, # 加入分群標示方框
          rect_border = "jco",           # 方框配色
          labels_track_height = 0.8)   
# 3B群聚圖-- fviz_cluster 函數將每筆資料畫在主成分的座標圖形中，並以顏色標示分群，觀察群聚
fviz_cluster(res.hcpc_w,
             repel = TRUE,              # 避免文字重疊
             show.clust.cent = TRUE,    # 顯示各群中心點
             palette = "jco")    
#3C查看分群結果
head(res.hcpc$data.clust)
# 變數相關的分群資訊--呼叫 catdes 函數分析結果
res.hcpc$desc.var$quanti


# 練習3
load("sales.RData")  #讀入sales檔案
head(sales)
str(sales)
sa <- sales[,c(3:5,6:7,9:10)] #選取相關欄位變數
head(sa) #，共7個，4-5補充屬量，7補充屬質
res.mca1 <- MCA(sa,ncp = 7, 
                quanti.sup = c(4:5),
                quali.sup = 7, 
                 graph = FALSE)
res.hcpc1 <- HCPC (res.mca1, graph = FALSE, max = 5)
fviz_dend(res.hcpc1, show_labels = FALSE, palette = "jco")
fviz_cluster(res.hcpc1, geom = "point", palette = "jco")
head(res.hcpc1$data.clust)
res.hcpc1$desc.var$category