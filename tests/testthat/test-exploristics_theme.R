test_that("exploristics_theme applied", {
  expect_no_error(scatterplot + exploristics_theme())
  expect_s3_class(scatterplot + exploristics_theme(), "ggplot")

  testObject <- scatterplot + exploristics_theme()

  expect_snapshot(testObject$theme)
})


test_that("theme_exploristics applied", {
  expect_no_error(scatterplot + theme_exploristics())
  expect_s3_class(scatterplot + theme_exploristics(), "ggplot")

  testObject <- scatterplot + theme_exploristics()

  expect_snapshot(testObject$theme)
})
