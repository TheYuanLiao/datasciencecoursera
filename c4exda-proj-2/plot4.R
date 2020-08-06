library(data.table)
library(dplyr)
library(ggplot2)

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Find the SCC code subset for coal combustion-related sources
scc_ei_sector <- as.character(unique(SCC$EI.Sector))
scc_ei_sector <- scc_ei_sector[grep("^(Fuel Comb -).*?(Coal).*?",
                                    scc_ei_sector)]
scc_coal_comb <- filter(SCC, EI.Sector %in% scc_ei_sector)$SCC

# Calculate coal-comb related emissions
total_coal <-
  NEI %>% filter(SCC %in% scc_coal_comb) %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

# Plot and save to .png
png("plot4.png", width = 480, height = 480)
g <- ggplot(total_coal, aes(year, total))
g + 
  geom_point(color="brown", size = 3) +
  geom_smooth(method = "lm") +
  labs(x = "Year", y="Total emissions (ton)", title="Source: coal combustion-related in the U.S.")
dev.off()