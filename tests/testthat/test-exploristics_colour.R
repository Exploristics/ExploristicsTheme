test_that("exploristics_colour applied", {
  expect_no_error(exploristics_colour(scatterplot))
  expect_s3_class(exploristics_colour(scatterplot), "ggplot")
})
