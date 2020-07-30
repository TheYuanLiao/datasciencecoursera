library(dplyr)
library(quantmod)
library(lubridate)

if (!dir.exists("data")) {dir.create("data")}

## Q1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = url, "data/idaho_housing_2006.csv")
DT <- tbl_df(read.csv("data/idaho_housing_2006.csv"))
ls <- names(DT)
# Apply strsplit() to split all the names of the data frame 
# on the characters "wgtp".
ls <- strsplit(ls, "wgtp")
print(ls[123])

## Q2-3
# Remove the commas from the GDP numbers in millions of dollars 
# and average them. What is the average?
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url = url, "data/GDP.csv")
gdp <- tbl_df(read.csv("data/GDP.csv", skip = 3))
# US.dollars.
gdp <- gdp %>%
  filter(!is.na(as.numeric(Ranking))) %>%
  mutate(US.dollars. = as.numeric(gsub(",", "", US.dollars.)))
print(mean(gdp$US.dollars., na.rm = TRUE))

# countries whose name begins with "United"
print(length(grep("^United", gdp$Economy)))

## Q4
## Education
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url = url, "data/edu.csv")
edu <- tbl_df(read.csv("data/edu.csv"))
merged <- merge(edu, gdp, by.x = "CountryCode", by.y = "X")
merged <- select(merged, CountryCode, Special.Notes)
print(length(grep("Fiscal year end: June", merged$Special.Notes)))

## Q5
amzn <- getSymbols("AMZN", auto.assign=FALSE)
sampleTimes <- index(amzn)
sT <- data.frame(year = sapply(sampleTimes, lubridate::year),
             wday = sapply(sampleTimes, lubridate::wday))
print(c(nrow(sT[sT$year == 2012,]),
        nrow(sT[(sT$wday == 2) & (sT$year == 2012),])))
