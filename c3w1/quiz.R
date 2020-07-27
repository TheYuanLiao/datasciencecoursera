library(data.table)
library(xlsx)
library(XML)
if (!dir.exists("data")) {dir.create("data")}

## Reading .csv
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = fileUrl, destfile = "./data/idaho_housing_2006.csv")
codeUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(url = codeUrl, destfile = "./data/idaho_housing_2006_codebook.pdf")

DT <- fread("./data/idaho_housing_2006.csv")

## Q1 How many properties are worth $1,000,000 or more
print(DT[DT$VAL == 24, .N])

## Reading .xlsx
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url = fileUrl, destfile = "./data/Natural_Gas_Aquisition.xlsx",
              mode='wb')
dat <- read.xlsx("./data/Natural_Gas_Aquisition.xlsx", sheetIndex = 1,
                 rowIndex = 18:23,
                 colIndex = 7:15)

## Q3 sum(dat$Zip*dat$Ext,na.rm=T)
print(sum(dat$Zip*dat$Ext,na.rm=T))

## Reading .xml
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- htmlTreeParse(sub("s", "", fileUrl), useInternal = TRUE)
rootNode <- xmlRoot(doc)
zipcode_list <- data.table(sapply(c("zipcode", "name"), 
                                  function (x) {xpathSApply(doc, 
                                                            paste("//", x, sep = ""), 
                                                            xmlValue)}))
print(zipcode_list[zipcode_list$zipcode == 21231, .N])

## Readubg .csv with data.table package
DT[, mean(pwgtp15), by=SEX]
