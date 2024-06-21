# Code to create plot for graph gallery

# Load Packages
library(ggplot2)
library(sf)
library(maps)
library(dplyr)

# Step 1: Generate Mock Data
set.seed(42)  # For reproducibility
states <- map_data("state")
unique_states <- unique(states$region)
mock_data <- data.frame(
  region = unique_states,
  value = runif(length(unique_states), min = 1, max = 100)
)

# Step 2: Prepare Spatial Data
us_states_sf <- st_as_sf(map("state", plot = FALSE, fill = TRUE))

# Merge mock data with spatial data
map_data <- us_states_sf %>%
  left_join(mock_data, by = c("ID" = "region"))

# Step 3: Create the Choropleth Map
choroplethMap <- ggplot(data = map_data) +
  geom_sf(aes(fill = value), color = "white", size = 0.2) +
  labs(
    title = "Choropleth Map of the United States",
    fill = "Value"
  ) +
  theme_exploristics() +
  scale_fill_continuous()+
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    axis.line = element_blank(),
    axis.title = element_blank(),
  )

ggsave(filename = "docs/")

