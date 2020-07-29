library(dplyr)
library(jpeg)
library(Hmisc)

setwd("c3w3")
if (!dir.exists("data")) {dir.create("data")}

## Q1.
## AGS - Sales of agriculture products
## ACR - Lot size
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = url, "data/microdata_2006_idaho.csv")
sv <- tbl_df(read.csv("data/microdata_2006_idaho.csv"))
sv <- sv %>%
        select(ACR, AGS) %>%
        mutate(agricultureLogical = (ACR == 3) & (AGS == 6))
agricultureLogical <- sv$agricultureLogical
print(which(agricultureLogical)[1:3])

## Q2 Read .jpg using jpeg
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url = url, "data/jeff.jpg", mode="wb")
img <- readJPEG("data/jeff.jpg", native=TRUE)
print(quantile(img, c(0.3, 0.8)))

## Q3 - 5
## GDP
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url = url, "data/GDP.csv")
gdp <- tbl_df(read.csv("data/GDP.csv", skip = 3))

## Education
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url = url, "data/edu.csv")
edu <- tbl_df(read.csv("data/edu.csv"))

# Merge
merged <- merge(edu, gdp, by.x = "CountryCode", by.y = "X")
merged <- select(merged, CountryCode, Long.Name, Ranking, Income.Group)

## Q3 Merge edu and gdp
merged$Ranking <- as.numeric(merged$Ranking)
merged <- merged[!is.na(merged$Ranking), ]
merged <- tbl_df(arrange(merged, desc(Ranking)))
print(merged[13, "Long.Name"])

## Q4 The average GDP ranking for the "High income: OECD" 
## and "High income: nonOECD" group
merged %>%
  group_by(Income.Group) %>%
  summarize(RankingMean = mean(Ranking))

## Q5 Cut the GDP ranking into 5 separate quantile groups. 
## Make a table versus Income.Group.
merged$RankingG <- cut2(merged$Ranking, g = 5)
table(merged$RankingG, merged$Income.Group)
