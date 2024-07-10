test_that("type argument is checked for proper input", {
  expect_snapshot_error(scale_fill_exploristics(type = scale_fill_brewer))
  expect_snapshot_error(scale_fill_exploristics(type = "abc"))
})

test_that("scale is applied", {
  testObject <- ggplot(mtcars, aes(x = wt, y = wt)) +
    geom_point(aes(fill = gear), pch = 21) +
    scale_fill_exploristics()

  # Fill is applied
  expect_identical(testObject[["scales"]][["scales"]][[1]][["aesthetics"]], "fill")

  # Appropriate colour applied for missing value
  expect_identical(testObject[["scales"]][["scales"]][[1]][["na.value"]], "#DA8280")

})
