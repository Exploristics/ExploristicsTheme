# Install and load necessary packages
if (!require("ggplot2")) install.packages("ggplot2")

library(ggplot2)

# Create mock data
set.seed(42)  # For reproducibility
data <- data.frame(
  x_value = runif(20, 1, 100),  # Random values for x-axis
  y_value = runif(20, 1, 100),  # Random values for y-axis
  size_value = runif(20, 1, 50),  # Random values for bubble size
  category = sample(LETTERS[1:4], 20, replace = TRUE)  # Random categories
)

# Display the mock data
print(head(data))

# Create the bubble plot using ggplot2
bubble_plot <- ggplot(data, aes(x = x_value, y = y_value, size = size_value, color = category)) +
  geom_point(alpha = 0.7) +  # Adjust transparency
  scale_size(range = c(2, 15), name = "Legend") +
  scale_color_discrete(name = "Legend") +# Adjust bubble size range
  labs(
    title = "Bubble Plot",
    subtitle = "4 Discrete Groups",
    caption = "Note: Exploristics theme applied",
    x = "X Value",
    y = "Y Value",
    size = "Bubble Size",
    color = "Category"
  ) +
  theme_exploristics() +
  guides(
    color = guide_legend(override.aes = list(size = 6)),  # Combine color legend
    size = guide_legend(override.aes = list(color = ExploristicsTheme::Expl_Rebrand[4]))  # Combine size legend
  )

ggsave(filename = "man/figures/bubbleplot.jpg", plot = bubble_plot)
