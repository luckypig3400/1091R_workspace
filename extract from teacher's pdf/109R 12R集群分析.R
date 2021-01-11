# 資料分析可以做什麼
# 拿到資料的可能分析判斷
# 1. 有標記—決策樹—萃取決策規則
# 2. 無標記—主成分分析+集群分析—分出各群，並尋找各群特色
w<-read.csv("wholesales.csv")
# 老闆會不會問你：哪個通路、哪個地區的哪種產品賣的好？
# 要如何分析？ 



# 常用資料探勘方法
# ‧ 非監督式學習(無標記性資料，無法預期可產生
#          何種輸出)：
# – 分群（集群）（Clustering) 演算法
# ‧ K Means
# – 關連性規則（Association Rule)
# ‧ 分群:同中求異，依據投入變數以及期待分出的
# 資料組數進行分群
# ‧ 分群後可以再做各群的特徵分析，找出各群
# ‧ 特徵



# ‧ 主成分分析（Principal Component Analysis）
# ‧ 資料來源：
# https://medium.com/marketingdatascience/%E4%B8%BB%E6%88%90%E5%
#   88%86%E5%88%86%E6%9E%90%E7%9A%84%E6%A6%82%E5%BF%B5
# %E5%8F%8A%E6%87%89%E7%94%A8-9807aac9c483
# ‧ 用少數變數描述眾多變數，--「降維」Dimension
# reduction



# ‧ 主成份分析能夠將一組高度相關的變數，建構出背後的「
# 指標（主成分）」。如學生的國語、英文、數學、社會、
# 自然成績，其指標為：「綜合成績」與「文理科成績」。
# 或是將棒球隊的一壘安打、二壘安打、三壘安打、全壘打
# 、打點、盜壘次數、四壞球等變數，進行主成份分析，可
# 得到「上壘」、「打擊者」、「安打」等指標。



# ‧ 要把類似的資料儘量排在一起，才能找到共同的端倪。而
# 「集群分析」正是一種精簡資料的方法，依據樣本之間的
# 共同屬性，將比較相似的樣本聚集在一起，形成集群
# (cluster)
# ‧ 集群分析（Cluster Analysis）的目標，是將樣本分為不同
# 的數個組，以使各組內的同質性最大化，以及各組之間的
# 異質性最大化
# ‧ 集群分析技術主要有兩大類：階層式分群（Hierarchical
# Clustering）和切割式分群（Partitional Clustering）



# ‧ 階層式分群（Hierarchical Clustering）不用指定分
# 群數量，演算法會直接根據樣本之間的距離，將
# 距離最近的集結在一群，直到所有樣本都併入到
# 同一個集群之中。階層式分群的結果，可透過樹
# 狀圖來呈現。



# ‧ 切割式分群（Partitional Clustering）則會事先指定
# 分群數量，並透過演算法（如K-means）讓組內同
# 質性和組間異質性最大化
# ‧ 集群分析主要用於將人分群，所依據的變數通常
# 是描述消費者的特徵（如，人口統計變數、態度
# 、需求…等）
# ‧ 美國職籃就曾將ESPN選出的前25名球星，包含得
# 分、籃板、助攻、火鍋及抄截等資料。以集群分
# 析法將25名球星分成五大類，分別是主力得分群
# 、防守猛將群、控球後衛群、雙能衛與強力前鋒
# 群，供球隊和經理和教練在選秀和調度時參考



# ‧ HCPC 主成分集群分析： FactoMineR 套件
# ‧ 2017 -08.新套件
# ‧ 群集分析：依據資料相似度找出適當的分群方式常見的群
# 集分析有階層式分群（hierarchical clustering）與分割式分
# 群（partitioning clustering-k-means）
# ‧ HCPC（Hierarchical Clustering on Principal Components）
# – 各種主成分分析法（PCA、CA、MCA、FAMD、MFA）。
# – 階層式分群
# – 分割式分群
# ‧ 資料來源：https://officeguide.cc/r-hcpc-hierarchical-clustering-on-principalcomponents-factominer-tutorial/
  
  
  
# ‧ 屬於連續型變數時，主成分分析（PCA）可以降
# 低資料的維度、保留重要的特徵，接著再以群集
# 分析對主成分分析的結果進行分群
# ‧ 類別型變數
# ‧ 先以對應分析（correspondence analysis，簡稱 CA
# ，針對列聯表）與多重對應分析（multiple
# correspondence analysis，MCA，針對多維度類別
# 型變數）將資料轉換成連續型變數（主成分），
# 後續再以群集分析接著處理。
# ‧ CA 或 MCA 可被視為一種將類別型變數轉換為連
# 續型變數的資料前處理。



# ‧ 混合型變數
# ‧ 資料同時包含連續型與類別型兩種變數時，可以
# 使用 FAMD（factor analysis of mixed data）或
# MFA（multiple factor analysis）方法，後續再以群
# 集分析接著處理



# ‧ FactoMineR--HCPC 分析方法
# – 主成分分析： PCA、CA、MCA、MFA（依據
# 資料類型與資料集結構選擇對應方法），可以
# 選擇要保留多少主成分（預設值為 5）。
# – 階層式分群：使用選定的各個主成分，根據華
# 德法（Ward’s method）進行階層式分群。華德
# 法與主成分分析的計算依據都是variance；根據
# 階層樹選定群集個數，建立起始的資料分群。
# – 分割式分群：以階層式分群結果為初始值，進
# 行 k - means 分群



# R程式
# FactoMineR 使用注意：需區分變數型態（屬量、屬質、混合），並需先執行主成分分析
# 安裝必要套件
install.packages(c("FactoMineR", "factoextra"))
# 載入必要 R 套件
library(factoextra)
library(FactoMineR) #視覺化套件
# 一.連續型變數----
str(USArrests)
# 使用內建資料集- USArrests



# HCPC 分析----
# 1.先以 PCA 函數對連續型資料進行主成分分析
# 主成分分析
res.pca <- PCA(USArrests, ncp = 3, graph = FALSE)
# 保留前三個主成分（ncp = 3），並且不顯示圖形（graph =FALSE）
# 繪製主成分分析相關圖形
plot(res.pca, choix = "ind")
plot(res.pca, choix = "var")
# 來源：https://officeguide.cc/r-hcpc-hierarchical-clustering-onprincipal-components-factominer-tutorial/
  
  
  
# 2.HCPC 分析
res.hcpc <- HCPC(res.pca, graph = FALSE)
# 樹狀圖 factoextra 的 fviz_dend 繪製由階層式分群所產生的樹狀圖
fviz_dend(res.hcpc,
          cex = 0.7, # 文字大小
          palette = "jco", # 文字配色
          rect = TRUE, rect_fill = TRUE, # 加入分群標示方框
          rect_border = "jco", # 方框配色
          labels_track_height = 0.8) # 文字顯示空間



# res.hcpc 包含資訊：
# data.clust：原始資料外加一欄分群資訊。
# desc.var：變數相關的分群資訊。
# desc.ind：個體相關的分群資訊。
# desc.axes：主成分座標軸相關的分群資訊
# 查看原始資料分群結果--- data.clust
head(res.hcpc$data.clust)
res.hcpc$data.clust
# 主成分座標軸相關的分群資訊--
res.hcpc$desc.axes$quanti



# 練習1.查看res.hcpc$data.clust，找出四集群的特徵，並命名



# ‧ 群1：人口少，謀殺少；群2：人口多，謀殺少
# ‧ 群3：人口少，謀殺多；群2：人口多，謀殺多



# ‧ 練習2
wholes <- read.csv("wholesales.csv")
str(wholes)
#1.資料矩陣操作
wh <- wholes[,c(2,6:8)]
str(wh)
# 請以wh檔案為基礎，完成集群分析，並說明各群可能特徵



#二、類別型變數----
# 載入 tea 資料集--內建於FactoMineR 套件
data(tea)
# 查看資料結構
str(tea)
head(tea)
# 1.# 先以MCA 分析，保留前20個維度
res.mca <- MCA(tea,
               ncp = 20, # 保留前 20 維度
               quanti.sup = 19, # 連續型補充變數
               quali.sup = c(20:36), # 類別型補充變數
               graph = FALSE)



# 2. HCPC 分析
res.hcpc <- HCPC (res.mca, graph = FALSE, max = 3)
# 樹狀圖
fviz_dend(res.hcpc, show_labels = FALSE, palette = "jco")
# 群聚圖
fviz_cluster(res.hcpc, geom = "point", palette = "jco")
# 查看HCPC 分析的結果中取得各種分群的細部資訊
# 原始資料加上分群結
head(res.hcpc$data.clust)



# 變數相關的分群資訊
res.hcpc$desc.var$category #有各群的特徵
res.hcpc$desc.var$test.chi2



# 練習3
load("sales.RData") #讀入sales檔案
head(sales)
str(sales)
sa <- sales[,c(3:5,6:7,9:10)] #選取相關欄位變數
head(sa) #共7個，4-5補充屬量，7補充屬質。
# 請用類別變數方式進行集群分析，看可以分出幾群，以及特徵為何