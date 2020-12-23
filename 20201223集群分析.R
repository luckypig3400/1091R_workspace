# FactoMineR 使用注意：需區分變數型態（屬量、屬質、混合），並需先執行主成分分析
# 安裝必要套件
install.packages(c("FactoMineR", "factoextra"))
# 載入必要 R 套件
library(factoextra)
library(FactoMineR) #視覺化套件

# 一.連續型變數----
str(USArrests)
# 使用內建資料集- USArrests

# HCPC 分析----
# 1.先以 PCA 函數對連續型資料進行主成分分析
# 主成分分析
res.pca <- PCA(USArrests, ncp = 3, graph = FALSE)
# 保留前三個主成分（ncp = 3），並且不顯示圖形（graph =FALSE）

# 繪製主成分分析相關圖形
plot(res.pca, choix = "ind")
plot(res.pca, choix = "var")
# 來源：https://officeguide.cc/r-hcpc-hierarchical-clustering-onprincipal-components-factominer-tutorial/

# 2.HCPC 分析
res.hcpc <- HCPC(res.pca, graph = FALSE)
# 樹狀圖 factoextra 的 fviz_dend 繪製由階層式分群所產生的樹狀圖
fviz_dend(res.hcpc,
          cex = 0.7, # 文字大小
          palette = "jco", # 文字配色
          rect = TRUE, rect_fill = TRUE, # 加入分群標示方框
          rect_border = "jco", # 方框配色
          labels_track_height = 0.8) # 文字顯示空間

