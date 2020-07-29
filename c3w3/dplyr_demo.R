library(dplyr)
chicago <- readRDS("chicago.rds")
str(chicago)

## select
head(select(chicago, 1:5))
head(select(chicago, -(city:dptp)))

## filter
chic.f <- filter(chicago, pm25tmean2 > 30)

## arrange
chicago <- arrange(chicago, date)
chicago <- arrange(chicago, desc(date))
head(chicago)

## rename
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)

## mutate
chicago <- mutate(chicago,
                  pm25detrend=pm25 - mean(pm25, na.rm = TRUE))

## groupby_by
chicago <- mutate(chicago, 
                  tempcat = factor(1 * (tmpd > 80), 
                                   labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
summarize(hotcold, pm25 = mean(pm25),
          o3 = max(o3tmean2), no2 = median(no2tmean2))

## %>%
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1)
        %>% group_by(month)
        %>% summarize(pm25 = mean(pm25, na.rm = TRUE),
                      o3 = max(o3tmean2, na.rm = TRUE), 
                      no2 = median(no2tmean2, na.rm = TRUE))