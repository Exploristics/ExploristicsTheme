scatterplot <- ggplot(data = mtcars, aes(x = hp, y = mpg, color = mpg)) +
  geom_point()

barplot <- ggplot(data = mtcars, aes(x = cyl, y = mpg, fill = as.factor(cyl))) +
  geom_bar(stat = "identity")
