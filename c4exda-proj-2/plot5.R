library(data.table)
library(dplyr)
library(ggplot2)

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Find the SCC code subset for mobile sources
scc_ei_sector <- as.character(unique(SCC$EI.Sector))
scc_ei_sector <- scc_ei_sector[grep("^Mobile - ",
                                    scc_ei_sector)]
scc_mobile <- filter(SCC, EI.Sector %in% scc_ei_sector)$SCC

# Calculate mobile related emissions for Baltimore
total_mobi <-
  NEI %>% filter(SCC %in% scc_mobile & fips == "24510") %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

# Plot and save to .png
png("plot5.png", width = 480, height = 480)
g <- ggplot(total_mobi, aes(year, total))
g + 
  geom_point(color="blue", size = 3) +
  geom_smooth(method = "lm") +
  labs(x = "Year", y="Total emissions (ton)", 
       title="Source: mobile vehicle in the Baltimore City, Maryland")
dev.off()