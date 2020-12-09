
#### TWSE ####
library(RCurl)
library(jsonlite)

qdate <- c('20201207', '20201208')
atype <- c('01', '02', '05', '10', '23')
TWSE_data <- data.frame()
for(date in qdate) {
    for(type in atype) {
        ttime <- as.character(as.integer(as.POSIXct(Sys.time()))*100)
        url <- paste0('http://www.twse.com.tw/exchangeReport/BFT41U?response=json&date=', date, '&selectType=', type,'&_=', ttime)
        A <- fromJSON(url, flatten=T)
        output <- as.data.frame(A$data)
        colnames(output) <- A$fields
        output$Type <- A$selectType
        output$Date <- A$date
        
        output$成交金額 <- gsub(pattern = ',', replacement = '', x = output$成交金額)
        output$成交數量 <- as.numeric(output$成交數量)
        output$成交筆數 <- as.numeric(output$成交筆數)
        output$成交金額 <- as.numeric(output$成交金額)
        output$成交價 <- as.numeric(output$成交價)
        output$最後揭示買量 <- as.numeric(output$最後揭示買量)
        output$最後揭示賣量 <- as.numeric(output$最後揭示賣量)
        
        output <- subset(output, output$證券名稱 != '合計')
        TWSE_data <- rbind(TWSE_data, output)
        
        Sys.sleep(30)
    }
}


library(ggplot2)
# Step1. Data
ggplot(data = TWSE_data)

# Step2. Aesthetic
ggplot(data = TWSE_data, aes(x = Type, y = 成交數量))

# Step3. Geometry
ggplot(data = TWSE_data, aes(x = Type, y = 成交數量)) + 
    geom_col()

# Step4. Facet
ggplot(data = TWSE_data[which(TWSE_data$Type == c('01', '02')),], aes(x = 證券名稱, y = 成交數量)) + 
    geom_col() + 
    facet_grid(Date~.)

# Step5. Statistics
ggplot(data = TWSE_data[which(TWSE_data$Type == c('01', '02')),], aes(x = 證券名稱, y = 成交數量)) + 
    geom_col() + 
    # stat_function(fun = 成交價 * 成交筆數)
    stat_summary(fun.min = function(x) mean(x) - sd(x), 
                 fun.max = function(x) mean(x) + sd(x), 
                 position ='dodge', 
                 geom = 'errorbar', 
                 aes(group = Type))

# Step6. Coordinates
ggplot(data = TWSE_data[which(TWSE_data$Type == c('01', '02')),], aes(x = 證券名稱, y = 成交數量)) + 
    geom_col() + 
    facet_grid(Date~.) + 
    coord_cartesian(ylim = c(0, 50))

# Step7. Theme
ggplot(data = TWSE_data[which(TWSE_data$Type == c('01', '02')),], aes(x = 證券名稱, y = 成交數量)) + 
    geom_col() + 
    facet_grid(Date~.) + 
    labs( x = '證券名稱', y = '成交量',
          title = '證券每日成交量',
          subtitle = '累積每日成交量',
          caption = '證交所')


# Other
ggplot(data = TWSE_data, aes(x = 成交金額, y = 成交數量)) + 
    geom_point() + 
    stat_smooth(method = "lm", formula = y ~ x, se=T, level=0.95)

ggplot(data = TWSE_data, aes(x = 成交價)) +
    geom_histogram()

ggplot(data = TWSE_data, aes(x = 成交價)) +
    geom_density() +
    geom_function(fun = dnorm, colour = "red")

