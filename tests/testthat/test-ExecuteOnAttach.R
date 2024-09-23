test_that("Exploristics Theme is applied", {

  ExecuteOnAttach()

  # Hard coded
  order <- c(1, 7, 4, 3, 11, 8, 2, 10, 6, 5, 12, 9)

  expect_equal(getOption("ggplot2.discrete.colour"),
               ExploristicsTheme::Expl_Brand[order])

  expect_equal(getOption("ggplot2.discrete.fill"),
               ExploristicsTheme::Expl_Brand[order])

  expect(is.function(getOption("ggplot2.continuous.colour")),
         failure_message = "The Option 'ggplot2.continuous.colour', should return a function")

  expect(is.function(getOption("ggplot2.continuous.fill")),
         failure_message = "The Option 'ggplot2.continuous.fill', should return a function")
})
