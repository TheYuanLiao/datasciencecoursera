library(data.table)
library(dplyr)

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the total by fips x year
total_fips <-
  NEI %>% group_by(fips, year) %>%
  summarize(total = sum(Emissions)) %>%
  filter(fips == "24510")
  
# Plot and save to .png
png("plot2.png", width = 480, height = 480)
with(total_fips, plot(year, total, size = 4,
                      xlab="Year",
                      ylab="Total emissions in the Baltimore City, Maryland (ton)"))
dev.off()