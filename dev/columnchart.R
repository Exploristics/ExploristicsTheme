# Install and load necessary packages
if (!require("ggplot2")) install.packages("ggplot2")
library(ggplot2)

# Create mock data
set.seed(42)  # For reproducibility
data <- data.frame(
  category = rep(c("X", "Y", "Z"), times = 7),
  subcategory = rep(c("A", "B", "C", "D", "E", "F", "G"), each = 3),
  value = sample(10:100, 21, replace = TRUE)
)

# Display the mock data
print(data)

# Create the stacked barplot using ggplot2
stacked_barplot <- ggplot(data, aes(x = reorder(category, value), y = value, fill = subcategory)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(
    title = "Stacked Barplot",
    subtitle = "7 Discrete Groups",
    caption = "Note: Exploristics theme applied",
    x = "Category",
    y = "Value",
    fill = "Subcategory"
  ) +
  exploristics_theme()


ggsave(filename = "man/figures/stackedbarplot.jpg")
