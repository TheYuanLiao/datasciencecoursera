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

# Calculate mobile related emissions for Baltimore and Los Angeles County
total_mobi_2c <-
  NEI %>% filter(SCC %in% scc_mobile & fips %in% c("24510", "06037")) %>%
  group_by(fips, year) %>%
  summarize(total = sum(Emissions)) %>%
  mutate(City=ifelse(fips == "24510", 
                     "Baltimore City, Maryland", 
                     "Los Angeles County, California"))
# Plot and save to .png
png("plot6.png", width = 800, height = 500)
g <- ggplot(total_mobi_2c, aes(year, total))
g + 
  geom_point(aes(color = City), size = 4) + 
  facet_grid(.~City) +
  geom_smooth(aes(color = City), method = "lm") +
  labs(x = "Year", y="Total emissions (ton)", title="Source: mobile vehicle")
dev.off()