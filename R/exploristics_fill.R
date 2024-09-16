#' @title Add Exploristics fill to a ggplot2 figure.
#' @description This function returns a ggplot with an Exploristics colour scheme
#'   added to it. There are 3 colour palettes to choose from. They are suitable
#'   for those with most common types of colour blindness.
#' @details This function sets the fill of the ggplot to a palette matching an
#'   Exploristics colour scheme. A gradient of the palette will be applied for
#'   continuous variables.
#'   \itemize{
#'    \item{`Expl_Blue` is a palette of 6 blues ranging from a dark navy to a
#'    light green-blue.}
#'    \item{`Expl_External` is a palette of 6 colours with purples, greens and
#'    blues.}
#'    \item{`Expl_HighCont` is a high-contrast palette of 6 colours with a variety of
#'    colours.}
#'    }
#' @param plot A ggplot2 figure (S3: gg, ggplot).
#' @param colour_pal The colour palette to use. Can be one of `Expl_Blue`,
#' `Expl_External` or `Expl_HighCont`. Defaults to `Expl_Blue`.
#' @param rev_gradient Should the reverse gradient of the colour palette be used
#'   (only for continuous variables). Defaults to `FALSE`.
#' @seealso \code{\link[ggplot2]{scale_color_manual}}
#' @seealso \code{\link[ggplot2]{scale_color_gradientn}}
#' @import 'ggplot2'
#' @importFrom grDevices colorRampPalette
#' @export
#' @examples
#' library(ggplot2)
#'
#' ## generate a plot with the Exploristics theme
#' ## if you want to use a numeric variable as discrete use `as.factor()` when setting `fill`
#' cars_plot <- ggplot(data = mtcars, aes(x = cyl, y = mpg, fill = as.factor(cyl))) +
#' geom_bar(stat="identity") +
#' exploristics_theme()
#'
#' ## adding the colour scheme can be written as one line
#' exploristics_fill(cars_plot, colour_pal="Expl_External")
#'
#'
#' library(magrittr)
#'
#' ## or using a pipe
#' cars_plot %>%
#' exploristics_fill(colour_pal="Expl_External")
#'
#'
#'
#' ## bar plots can appear to have "lines" within the bars if only setting colour
#' ## if this happens set the colour to the same as the fill in the plot aes()
#' ## and add exploristics_colour()
#' cars_plot <- ggplot(data = mtcars, aes(x = cyl, y = mpg, fill =
#' as.factor(cyl),colour=as.factor(cyl))) +
#' geom_bar(stat = "identity") +
#' exploristics_theme()
#'
#' cars_plot %>%
#' exploristics_fill(colour_pal = "Expl_External") %>%
#' exploristics_colour(colour_pal = "Expl_External")


exploristics_fill <-
  function(plot,
           colour_pal = "Expl_Blue",
           rev_gradient = FALSE) {
    # ensure the chosen colour palette is one of the Explorisitics palettes
    colourPalette <-
      match.arg(colour_pal,
                choices = c("Expl_Blue", "Expl_External", "Expl_HighCont"))

    fill_class <-
      retrieve_aesthetic_class(plot, aesthetics = "fill")

    # discrete or continuous functions needed?
    if (fill_class %in% c("logical", "character", "factor", "ordered")) {
      # discrete

      fill_num <- length(unique((layer_data(plot)$fill)))

      # use specified colours from palette if 6 or less needed.
      # create colorRampPalette if >6 needed.
      if (fill_num <= 6) {
        plot <-
          plot + scale_fill_manual(values = get(colourPalette)[1:fill_num])

      } else {
        plot <-
          plot + scale_fill_manual(values = grDevices::colorRampPalette(get(colourPalette))(fill_num))

      }
    } else {
      colours <- get(colourPalette)[GradientLUT[colourPalette]]

      if (isTRUE(rev_gradient)) {
        colours <- rev(colours)
      }

      plot + scale_fill_gradientn(colours = colours)
    }

    return(plot)

  }
