install.packages("httr")
install.packages("XML")
#### XML API ####
library(httr)
library(XML)

url <- 'https://data.gcis.nat.gov.tw/od/data/api/5F64D864-61CB-4D0D-8AD9-492047CC1EA6?$format=xml&$filter=Business_Accounting_NO%20eq%2020828393&$skip=0&$top=50'
xml_doc <- xmlParse(GET(url)) # 以 xmlParse 解析 XML 檔案
xml_files <- xmlRoot(xml_doc) # 將 root 設定到 content 層級（一個偷吃步的做法）
data <- xmlToDataFrame(xml_files) # 轉換成 dataframe


#### JASON API ####
library(jsonlite)

url <- 'https://data.gcis.nat.gov.tw/od/data/api/5F64D864-61CB-4D0D-8AD9-492047CC1EA6?$format=json&$filter=Business_Accounting_NO%20eq%2020828393&$skip=0&$top=50'
data <- fromJSON(url, flatten = TRUE)


#### TWSE ####
library(RCurl)
library(jsonlite)

qdate <- '20201201'
qtype <- 'ALLBUT0999'
ttime <- as.character(as.integer(as.POSIXct(Sys.time()))*100)
url <- paste0('https://www.twse.com.tw/exchangeReport/BFT41U?response=json&date=', qdate, '&selectType=', qtype,'&_=', ttime)
A <- fromJSON(url, flatten=T)
data_20201201 <- as.data.frame(A$data)
colnames(data_20201201) <- A$fields


#### NBA ####
library(RCurl)
library(XML)

url <- 'https://www.basketball-reference.com/leagues/NBA_2020_games.html'
page_parsed <- htmlParse(GET(url))
url_n <- xpathSApply(page_parsed, '//*[@id="schedule"]/tbody//td[6]/a', xmlAttrs, 'href')
dates_nt <- xpathSApply(page_parsed, '//*[@id="schedule"]/tbody//th/a', xmlValue)
dates_n <- gsub(',', '', gsub('[ ]', '-', substring(dates_nt, 6)))

url_b <- 'http://www.basketball-reference.com'
url_new <- paste(url_b,url_n,sep = '')

# length(url_new)
for (i in 1:length(url_new)){
    url <- url_new[i]
    table_parsed <- htmlParse(GET(url)) 
    table_a <- readHTMLTable(table_parsed)
    
    tn_table <- names(table_a)[grepl('basic', names(table_a))]
    
    table1 <- table_a[tn_table[1]]
    table1 <- data.frame(table1)
    table1$dates <- dates_n[i]
    table1$match <- 'home'
    
    page1_parsed <- htmlParse(GET(url))
    table1$team <- xpathSApply(page1_parsed, '//*[@id="content"]/div[2]/div[1]/div[1]/strong/a', xmlValue)
    
    colnames(table1) <- c('Names', 'MP', 'FG', 'FGA', 'FG_P', 
                          '3P', '3PA', '3P_P', 'FT', 'FTA', 
                          'FT_P', 'ORB', 'DRB', 'TRB', 'AST', 
                          'STL', 'BLK', 'TOV', 'PF', 'PTS', 
                          '+/-', 'dates', 'match', 'team')
    
    table1 <- na.exclude(subset(table1, table1$Names != 'Reserves'))
    
    table3 <- table_a[tn_table[2]]
    table3 <- data.frame(table3)
    table3$dates <- dates_n[i]
    table3$match <- 'away'
    
    table3$team <- xpathSApply(page1_parsed, '//*[@id="content"]/div[2]/div[2]/div[1]/strong/a', xmlValue)
    
    colnames(table3) <- c('Names', 'MP', 'FG', 'FGA', 'FG_P', 
                          '3P', '3PA', '3P_P', 'FT', 'FTA', 
                          'FT_P', 'ORB', 'DRB', 'TRB', 'AST', 
                          'STL', 'BLK', 'TOV', 'PF', 'PTS', 
                          '+/-', 'dates', 'match', 'team')
    
    table3 <- na.exclude(subset(table3, table3$Names != 'Reserves'))
    
    if (i == 1){
        table_all <- rbind(table1, table3)
    } else {
        table_all <- rbind(table_all, table1, table3)
    }
}


