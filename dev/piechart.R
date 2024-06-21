# Install and load necessary packages
library(ggplot2)
library(dplyr)

# Create sample data
data <- data.frame(category = c("A", "B", "C", "D"),
                   value = c(10, 20, 30, 40))

# Compute the percentage
data <- data %>%
  mutate(percentage = value / sum(value) * 100)

# Compute the cumulative percentage for positioning the labels
data <- data %>%
  arrange(desc(category)) %>%
  mutate(ypos = cumsum(percentage) - 0.5 * percentage)

# Basic pie chart with ggplot
pie_chart <-
  ggplot(data, aes(x = "", y = percentage, fill = category)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0)

# Create the doughnut effect by adding a white circle in the middle
doughnut_chart <- pie_chart +
  geom_text(aes(y = ypos, label = paste0(round(percentage), "%")), color = "white") +
  labs(title = "Doughnut Chart",
       subtitle = "4 Discrete Groups",
       caption = "Note: Exploristics theme applied",
       fill = "Category") +
  theme_exploristics() +
  theme(axis.title = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank()) +
  annotate("text", x = 0, y = 0, label = "", size = 20, color = "white")



ggsave(filename = "man/figures/doughnut.jpg")
