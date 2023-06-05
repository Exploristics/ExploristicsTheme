test_that("add_footer creates file", {
  path <- tempfile(fileext = ".png")
  on.exit(unlink(path))

  scatterplot
  ggsave(path, scatterplot, width = 8, height = 8, dpi = 300)

  expect_false(file.exists(paste0(file_path_sans_ext(path),"_with_footer.png")))

  add_footer(path)
  expect_true(file.exists(paste0(file_path_sans_ext(path),"_with_footer.png")))
})
