test_that("Exploristics Theme is applied", {

  ExecuteOnAttach()

  expect_equal(getOption("ggplot2.discrete.colour"),
               ExploristicsTheme::Expl_Rebrand)

  expect_equal(getOption("ggplot2.discrete.fill"),
               ExploristicsTheme::Expl_Rebrand)

  expect(is.function(getOption("ggplot2.continuous.colour")),
         failure_message = "The Option 'ggplot2.continuous.colour', should return a function")

  expect(is.function(getOption("ggplot2.continuous.fill")),
         failure_message = "The Option 'ggplot2.continuous.fill', should return a function")
})
