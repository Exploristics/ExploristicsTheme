#' @title Add Exploristics colour to a ggplot2 figure.
#' @description This function returns a ggplot with an Exploristics colour scheme
#'   added to it. There are 3 colour palettes to choose from. They are suitable
#'   for those with most common types of colour blindness.
#' @details This function sets the colour of the ggplot to a palette matching an
#'   Exploristics colour scheme. A gradient of the palette will be applied for continuous variables.
#'   \itemize{
#'   \item{`Expl_Blue` is a palette of 6 blues ranging from a dark navy to a light green-blue.}
#'   \item{`Expl_External` is a palette of 6 colours with purples, greens and blues.}
#'   \item{`Expl_HighCont` is a high-contrast palette of 6 colours with a variety of colours.}
#'   }
#' @param plot A ggplot2 figure (S3: gg, ggplot).
#' @param colour_pal The colour palette to use. Can be one of `Expl_Blue`, `Expl_External` or `Expl_HighCont`. Defaults to `Expl_Blue`
#' @param rev_gradient Should the reverse gradient of the colour palette be used (only for continuous variables). Defaults to `FALSE`.
#' @seealso \code{\link[ggplot2]{scale_color_manual}}
#' @seealso \code{\link[ggplot2]{scale_color_gradientn}}
#' @import 'ggplot2'
#' @importFrom grDevices colorRampPalette
#' @export
#' @examples
#' library(ggplot2)
#'
#' ## generate a plot with the Exploristics theme
#' cars_plot <- ggplot(data = mtcars, aes(x = hp, y = mpg, colour = mpg)) +
#' geom_point(size=2) +
#' exploristics_theme()
#'
#' ## adding the colour scheme can be written as one line
#' exploristics_colour(cars_plot, colour_pal="Expl_External")
#'
#'
#' library(magrittr)
#'
#' ## or using a pipe
#' cars_plot %>%
#' exploristics_colour(colour_pal="Expl_External")

exploristics_colour <-
  function(plot,
           colour_pal = "Expl_Blue",
           rev_gradient = FALSE) {
    # ensure the chosen colour palette is one of the Explorisitcs palettes
    colourPalette <-
      match.arg(colour_pal,
                choices = c("Expl_Blue", "Expl_External", "Expl_HighCont"))

    # Check whether colour or color used


    # work out number of colours needed for colour
    colour_class <-
      retrieve_aesthetic_class(plot, aesthetics = c("colour", "color"))

    # discrete or continuous functions needed?
    if (colour_class %in% c("logical", "character", "factor", "ordered")) {
      # discrete


      colour_num <- length(unique((layer_data(plot)$colour)))

      # use specified colours from palette if 6 or less needed.
      # create colorRampPalette if >6 needed.
      if (colour_num <= 6) {
        plot <-
          plot + scale_color_manual(values = get(colourPalette)[1:colour_num])

      } else {
        plot <-
          plot + scale_color_manual(values = grDevices::colorRampPalette(get(colourPalette))(colour_num))

      }

    } else {
      if (isTRUE(rev_gradient)) {
        # continuous
        if (colourPalette == "Expl_Blue") {
          plot <- plot + scale_color_gradientn(colours = rev(ExploristicsTheme::Expl_Blue))
        }
        if (colourPalette == "Expl_External") {
          plot <-
            plot + scale_color_gradientn(colours = rev(ExploristicsTheme::Expl_External[c(1, 6, 2)]))
        }
        if (colourPalette == "Expl_HighCont") {
          plot <-
            plot + scale_color_gradientn(colours = rev(ExploristicsTheme::Expl_HighCont[c(1, 2, 4)]))
        }
      } else {
        # continuous
        if (colourPalette == "Expl_Blue") {
          plot <- plot + scale_color_gradientn(colours = ExploristicsTheme::Expl_Blue)
        }
        if (colourPalette == "Expl_External") {
          plot <-
            plot + scale_color_gradientn(colours = ExploristicsTheme::Expl_External[c(1, 6, 2)])
        }
        if (colourPalette == "Expl_HighCont") {
          plot <-
            plot + scale_color_gradientn(colours = ExploristicsTheme::Expl_HighCont[c(1, 2, 4)])
        }
      }

    }

    return(plot)

  }
