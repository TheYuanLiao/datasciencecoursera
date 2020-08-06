library(data.table)
library(dplyr)

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the total
total <- tapply(NEI$Emissions, NEI$year, sum)

# Plot and save to .png
png("plot1.png", width = 480, height = 480)
plot(c(1999, 2002, 2005, 2008),
     total,
     size = 4,
     xlab="Year",
     ylab="Total emissions in the U.S. (ton)")
dev.off()