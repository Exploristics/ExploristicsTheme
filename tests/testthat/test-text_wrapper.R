test_that("text_wrapper applied", {
  expect_no_error(text_wrapper(barplot))
  expect_s3_class(text_wrapper(barplot), "ggplot")
})
