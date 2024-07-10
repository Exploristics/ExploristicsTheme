test_that("exploristics_theme applied", {
  expect_no_error(scatterplot + exploristics_theme())
  expect_s3_class(scatterplot + exploristics_theme(), "ggplot")
})
