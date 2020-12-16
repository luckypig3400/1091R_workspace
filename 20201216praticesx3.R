# 練習 1
install.packages("AER")
library(AER)
data(CreditCard)
head(CreditCard)
# 請用不同的決策樹套件，必要時可以剪枝，找出信用卡是否核准的準則
# 因變數：card，自變數—
# A.全選
# B.選：reports, age. income, expenditure, owner, months
# 信用貶弱報告數(reports)、年齡(age)、收入(imcome)、自有住宅狀況(owners)
# 、往來時間(months)影響Y是否核准卡片



# 練習2
# 載入sales_D.Rdata，因變數： group_p，挑選不同變
# 數，調整control = rpart.control(cp = 0.001)—剪枝，
# 如：0.05等去做調整
# 請適用不同的決策樹套件，必要時可以剪枝，找出group_p屬於L/H的準則
load("sales_D.RData")
head(sales_D)
str(sales_D)



# 練習3：使用ggplot2的diamonds 資料練習跑決策
# 樹，找出切割完美與否的影響因素（類別樹），
# 以及價格的影響因素（數值樹）
install.packages("ggplot2")
library(ggplot2)
head(diamonds)