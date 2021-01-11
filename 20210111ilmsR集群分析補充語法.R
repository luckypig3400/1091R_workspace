# 樹狀圖 factoextra 的 fviz_dend 繪製由階層式分群所產生的樹狀圖
fviz_dend(res.hcpc,
          cex = 0.7,                     # 文字大小
          palette = "jco",               # 文字配色（可參考 ?ggpubr::ggpar）
          rect = TRUE, rect_fill = TRUE, # 加入分群標示方框
          rect_border = "jco",           # 方框配色
          labels_track_height = 0.8)     # 文字顯示空間

# 群聚圖-- fviz_cluster 函數將每筆資料畫在主成分的座標圖形中，並以顏色標示分群，觀察群聚
fviz_cluster(res.hcpc,
             repel = TRUE,              # 避免文字重疊
             show.clust.cent = TRUE,    # 顯示各群中心點
             palette = "jco")           # 文字配色（可參考 ?ggpubr::ggpar）

# 亦可將樹狀圖與群聚圖合併成一張 3D 的圖形：
# 樹狀圖與群聚圖合併
plot(res.hcpc, choice = "3D.map")