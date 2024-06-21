# Install and load necessary packages
library(ggplot2)
library(dplyr)
library(tidyr)
library(tibble)

# Create mock data (matrix format)
set.seed(42)  # For reproducibility
data_matrix <- matrix(runif(100, min = 1, max = 10), nrow = 10, ncol = 10)
rownames(data_matrix) <- paste(1:10)
colnames(data_matrix) <- paste(1:10)

# Convert the matrix to a data frame
data_df <- as.data.frame(data_matrix)
data_df <- data_df %>%
  rownames_to_column(var = "Row") %>%
  pivot_longer(-Row, names_to = "Column", values_to = "Value")


# Create the heatmap using ggplot2
heatmap <- ggplot(data_df, aes(x = Column, y = Row, fill = Value)) +
  geom_tile() +
  labs(
    title = "Heatmap",
    subtitle = "Continious Colour Scale",
    caption = "Note: Exploristics theme applied",
    x = "Columns",
    y = "Rows",
    fill = "Value"
  )

ggsave(filename = "man/figures/heatmap.jpg", plot = heatmap)


