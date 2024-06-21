# Install and load necessary packages
if (!require("ggplot2")) install.packages("ggplot2")

library(ggplot2)

# Create mock data
set.seed(42)  # For reproducibility
group <- rep(c("A", "B", "C", "D"), each = 50)
value <- c(rnorm(50, mean = 10, sd = 2),
           rnorm(50, mean = 12, sd = 2),
           rnorm(50, mean = 9, sd = 2),
           rnorm(50, mean = 11, sd = 2))

data <- data.frame(group = factor(group), value = value)

# Display the mock data
print(head(data))

# Create the boxplot using ggplot2
boxplot <- ggplot(data, aes(x = group, y = value, fill = group)) +
  geom_boxplot() +
  labs(
    title = "Boxplot",
    subtitle = "4 Discrete Groups",
    caption = "Note: Exploristics theme applied",
    x = "Group",
    y = "Value",
    fill = "Group"
  ) +
  theme_exploristics( ) +
  coord_flip()

ggsave(filename = "man/figures/boxplot.jpg")
