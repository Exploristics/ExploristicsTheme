test_that("save_with_logo creates file with provided filename for ggplot input",
          {
            path <- tempfile(fileext = ".png")
            on.exit(unlink(path))

            expect_false(file.exists(paste0(
              tools::file_path_sans_ext(path), "_test.png"
            )))

            save_with_logo(scatterplot,
                           filename = paste0(tools::file_path_sans_ext(path), "_test.png"))

            expect_true(file.exists(paste0(
              tools::file_path_sans_ext(path), "_test.png"
            )))
          })

test_that("save_with_logo creates file with footer for image file input", {
  path <- tempfile(fileext = ".png")
  on.exit(unlink(path))

  scatterplot
  ggsave(path,
         scatterplot,
         width = 8,
         height = 8,
         dpi = 300)

  expect_false(file.exists(paste0(
    tools::file_path_sans_ext(path), "_with_footer.png"
  )))

  save_with_logo(path)

  expect_true(file.exists(paste0(
    tools::file_path_sans_ext(path), "_with_footer.png"
  )))
})
