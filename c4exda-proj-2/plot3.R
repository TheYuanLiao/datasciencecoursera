library(data.table)
library(dplyr)
library(ggplot2)

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the total by type x year for Baltimore City
total_b_type <-
  NEI %>% filter(fips == "24510") %>%
  group_by(type, year) %>%
  summarize(total = sum(Emissions))
  

# Plot and save to .png
png("plot3.png", width = 800, height = 500)
g <- ggplot(total_b_type, aes(year, total))
g + 
  geom_point(aes(color = type), size = 4) + 
  facet_grid(.~type) +
  geom_smooth(aes(color = type), method = "lm") +
  labs(x = "Year", y="Total emissions (ton)", title="Baltimore City, Maryland")
dev.off()