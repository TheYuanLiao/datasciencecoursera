## This is the script for solving Course 3/Week 2 Quiz
## More on reading data of different formats.

library(httr)
library(data.table)
library(jsonlite)
library(sqldf)
library(XML)

## Reading the Github API (Q1)
appnm <- "api_github"
token <- fromJSON("tokens.json") 
oauth_endpoints("github")
myapp <- oauth_app(appnm,
                   key = token[token$app == appnm]$key,
                   secret = token[token$app == appnm]$secret
)
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
extr_func <- function (x) {data.table(name = x$name, 
                                      created_at = x$created_at)}
dat <- rbindlist(lapply(content(req), extr_func))
print(dat[dat$name == "datasharing", created_at])

## Reading csv and execute SQL with R data frames (Q2-3)
if (!dir.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url = fileUrl, destfile = "./data/arcs.csv")
acs <- read.csv("./data/arcs.csv")
# sqldf("SELECT pwgtp1 FROM acs WHERE AGEP < 50")
unique(acs$AGEP)

## Reading HTML as raw format (Q4)
fileUrl <- "http://biostat.jhsph.edu/~jleek/contact.html"
doc <- getURL(fileUrl)
doc <- strsplit(doc[[1]], split= "\\n")
print(nchar(doc[c(10, 20, 30, 100)]))

## Reading a dataset online (Q5)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url = url, destfile = "./data/unknown.csv")
df <- read.fwf("./data/unknown.csv", widths = c(10, 5, 4, 4, 
                                                5, 4, 4,
                                                5, 4, 4,
                                                5, 4, 4),
               skip = 4, sep = "\t")
df <- df[, colSums(is.na(df)) != nrow(df)]
colnames(df) <- c("Week", "Nino1+2.SST", "Nino1+2.SSTA", 
                  "Nino3.SST", "Nino3.SSTA", 
                  "Nino34.SST", "Nino34.SSTA",
                  "Nino4.SST", "Nino4.SSTA")
sum(df[, colnames(df)[4]])
