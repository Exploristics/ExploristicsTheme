test_that("theme_exploristics applied", {
  expect_no_error(scatterplot + theme_exploristics())
  expect_s3_class(scatterplot + theme_exploristics(), "ggplot")
})
