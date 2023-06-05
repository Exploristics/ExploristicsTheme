test_that("exploristics_fill applied", {
  expect_no_error(exploristics_fill(barplot))
  expect_s3_class(exploristics_fill(barplot), "ggplot")
})
