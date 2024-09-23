#' @title Save a ggplot2 and add a footer with the Exploristics logo.
#' @description This function saves a ggplot with a footer with the Exploristics logo and an optional text caption added below the plot.
#' @details This function saves a ggplot with a footer with the Exploristics logo at the bottom-right corner and an optional text caption at the bottom-left corner below the plot.
#' There is also an option to add a line between the plot and the footer.
#' The plot will be saved with the footer added is saved to a the provided filename as a `.png` file.
#' An image file can also be used with this function, so the Exploristics logo can be added to any plot. The footer will be added to the image then saved to a `.png` file with the same filename as the original plot image but with the suffix "with_footer" added to it.
#' @param plot A ggplot or the path to an image file.
#' @param filename The file to save the image to. Don't include file extension as it will be saved as a `.png`.
#' @param text Optional text to add to the left of the footer. Single line or across 2 lines if you add `\n` between the lines of text.
#' @param line Add a line between the plot and the footer. Defaults to `FALSE`.
#' @param logo Path to an image file to use in the footer. The path must be URL, filename or raw vector. Defaults uses the Exploristics logo supplied with the package.
#' @param width Width of the plot to save, in inches. Only used if `plot` is a ggplot. Defaults to `8`.
#' @param height Height of the plot to save, in inches. Only used if `plot` is a ggplot. Defaults to `8`.
#' @param dpi Dots per inch to use when saving the plot. Only used if `plot` is a ggplot. Defaults to `300`.
#' @param suffix Suffix to add to the original plot filename. Only used if `plot` is an image file. Don't need to include file extension. Defaults to "_with_footer".
#' @param darkbg Default is `FALSE`, which uses the Exploristics logo with dark text. Set to `TRUE` if using a dark background colour in the plot so an Exploristics logo with white text will be applied instead.
#' @seealso \code{\link[ggplot2]{ggsave}}
#' @seealso \code{\link[magick]{image_read}}
#' @seealso \code{\link[magick]{image_trim}}
#' @seealso \code{\link[magick]{image_scale}}
#' @seealso \code{\link[magick]{image_background}}
#' @seealso \code{\link[magick]{image_extent}}
#' @seealso \code{\link[magick]{image_border}}
#' @seealso \code{\link[magick]{image_annotate}}
#' @seealso \code{\link[magick]{image_info}}
#' @seealso \code{\link[magick]{image_blank}}
#' @seealso \code{\link[magick]{image_append}}
#' @seealso \code{\link[magick]{image_write}}
#' @import 'ggplot2'
#' @import 'magick'
#' @import 'magrittr'
#' @importFrom tools file_path_sans_ext
#' @export
#' @examples
#' library(ggplot2)
#' library(magick)
#' library(magrittr)
#' library(scales)
#' library(stringr)
#'
#' ## generate a plot with the Exploristics theme
#' cars_plot <- ggplot(data = mtcars, aes(x = hp, y = mpg, colour = mpg)) +
#' geom_point(size=2) +
#' labs(title="Example plot") +
#' exploristics_theme()
#'
#' ## add colour scheme, wrap text labels and save with the Exploristics logo
#' cars_plot %>%
#' exploristics_colour(colour_pal="Expl_RGB") %>%
#' text_wrapper() %>%
#' save_with_logo(filename="example_cars_plot", text= "Source:Data source\nProduced by: Name",
#' width = 8, height = 8, dpi = 300)
#'
#'
#' ## Alternatively, add the Exploristics logo to a previously saved plot ##
#'
#' ## generate a plot with the Exploristics theme
#' cars_plot <- ggplot(data = mtcars, aes(x = hp, y = mpg, colour = mpg)) +
#' geom_point(size=2) +
#' labs(title="Example plot") +
#' exploristics_theme()
#'
#' ## add colour scheme and wrap text labels
#' cars_plot %>%
#' exploristics_colour(colour_pal = "Expl_RGB") %>%
#' text_wrapper()
#'
#' ## save the plot
#' ggsave(filename = "example_cars_plot.png", width = 8, height = 8, dpi = 300)
#'
#' ## add the footer with the logo to the saved image
#' save_with_logo("example_cars_plot.png",
#' text = "Source:Data source\nProduced by: Name")

save_with_logo <-
  function(plot = NULL,
           filename = NULL,
           text = NULL,
           line = FALSE,
           logo = NULL,
           width = 8,
           height = 8,
           dpi = 300,
           suffix = NULL,
           darkbg = FALSE) {

    if (is.null(plot)) {
      stop("No plot provided. Please supply a ggplot or the path of a previously saved image.")
    }

    # check if plot is a ggplot or an image file
    if (is.ggplot(plot)) {
      # create a temp file to save the plot to
      tmpfile <- tempfile(fileext = ".png")
      # plot the plot
      plot

      # save the plot
      ggsave(filename = tmpfile,
             plot = plot,
             width = width,
             height = height,
             dpi = dpi)

      if (is.null(filename)) {
        stop("No filename provided. Please enter a filename.")
      } else {
        # don't use a suffix when saving
        use_suffix <- FALSE

        # read in the plot
        plot_img <- image_read(tmpfile)

      }
    } else {
      # set the file name to the one provided and use a suffix when saving
      filename <- plot
      use_suffix <- TRUE

      # read in the plot
      plot_img <- image_read(filename)

    }


    # get plot info
    plot_info <- image_info(plot_img)

    if (is.null(logo)) {
      if (isTRUE(darkbg)){
        # read in the logo with dark text
        logo_raw <-
          image_read(system.file("extdata", "Exploristics_Logo_RGB_Mono_Reversed.png", package =
                                   "ExploristicsTheme"))
      } else{
        # read in the logo with dark text
        logo_raw <-
          image_read(system.file("extdata", "Exploristics_Logo_RGB.jpg", package =
                                   "ExploristicsTheme"))
      }

    } else {
      logo_raw <-  image_read(logo)
    }


    # calculate the scaling needed for the logo based on the dimensions of the plot
    # square
    scale_logo_num <- round(plot_info$height * 0.125, 0)
    scale_extent_num <-
      paste0(round(plot_info$height / 1.846, 0), "x75")#, round(plot_info$height/32,0))

    # long
    if (plot_info$height > plot_info$width) {
      scale_logo_num <- round(plot_info$width * 0.125, 0)
      scale_extent_num <-
        paste0(round(plot_info$width / 1.846, 0), "x75")#, round(plot_info$height/32,0))

    }
    # wide
    if (plot_info$height < plot_info$width) {
      scale_logo_num <- round(plot_info$height * 0.125, 0)
      scale_extent_num <-
        paste0(round(plot_info$width / 1.846, 0), "x75")#, round(plot_info$height/32,0))
    }

    # scale down the logo and give it a border so it's on the right side of the footer
    footer <- logo_raw %>%
      image_trim() %>%
      image_scale("300") %>%
      image_background(Backgroud_Colour, flatten = TRUE) %>% # #A2D7E4
      image_extent(scale_extent_num,
                   gravity = "east",
                   color = Backgroud_Colour) %>%
      image_border("10x10", color = Backgroud_Colour)

    # if text caption is to be added, put it on the left side of the footer
    if (!is.null(text)) {
      if (isTRUE(grepl("\n", text))) {
        footer <- footer %>%
          image_annotate(
            text,
            color = Footer_Text_Colour,
            size = 25,
            location = "+10+15",
            gravity = "northwest"
          )
      } else {
        footer <- footer %>%
          image_annotate(
            text,
            color = Footer_Text_Colour,
            size = 25,
            location = "+10+25",
            gravity = "northwest"
          )
      }

    }

    # if using a line between the plot and footer, create it
    if (isTRUE(line)) {
      # new image to act as a line break
      # make it the same length as the footer
      lb_width <- image_info(footer)$width
      lb_height <- 3
      lb <-
        image_blank(lb_width, lb_height, color = Footer_Text_Colour)

      # set final plot dimensions to the same as the original plot
      final_dim <- paste0(plot_info$width, "x", plot_info$height)

      # stack the 3 images (plot, line, footer) on top of each other
      final_plot <-
        image_append(image_scale(c(plot_img, lb, footer), final_dim), stack = TRUE)
    } else {
      # set final plot dimensions to the same as the original plot
      final_dim <- paste0(plot_info$width, "x", plot_info$height)

      # stack the 2 images (plot, footer) on top of each other
      final_plot <-
        image_append(image_scale(c(plot_img, footer), final_dim), stack = TRUE)
    }

    if (isTRUE(use_suffix)) {
      if (is.null(suffix)) {
        # save the plot with the footer added to the given filename with the default suffix
        image_write(final_plot,
                    paste0(
                      tools::file_path_sans_ext(filename),
                      "_with_footer.png"
                    ))

      } else {
        # save the plot with the footer added to the given filename with the suffix provided
        image_write(final_plot,
                    paste0(tools::file_path_sans_ext(filename), suffix, ".png"))

      }
    } else {
      # save the plot with the footer added to the given filename
      image_write(final_plot, paste0(tools::file_path_sans_ext(filename), ".png"))

      # remove the temp file
      unlink(tmpfile)
    }

  }
