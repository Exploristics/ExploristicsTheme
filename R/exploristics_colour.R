#' @title Add Exploristics colour to a ggplot2 figure.
#' @description This function returns a ggplot with an Exploristics colour scheme added to it.
#'   There are 3 colour palettes to choose from.They are suitable for those with most common types of colour blindness.
#' @details This function sets the colour of the ggplot to a palette matching an
#'   Exploristics colour scheme. A gradient of the palette will be applied for continuous variables.
#'   `Expl_Blue` is a palette of 6 blues ranging from a dark navy to a light green-blue.
#'   `Expl_External` is a palette of 6 colours with purples, greens and blues.
#'   `Expl_HighCont` is a high-contrast palette of 6 colours with a variety of colours.
#' @param plot A ggplot2 figure (S3: gg, ggplot).
#' @param colour_pal The colour palette to use. Can be `Expl_Blue`, `Expl_External` or `Expl_HighCont`. Defaults to `Expl_Blue`
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
    # colour palettes
    # Expl_Blue <- c("#002659","#293D94","#136BBA","#16A4D4","#9DD6E4","#D6EFF5")
    # Expl_External <- c("#7119A2","#28CAAB","#3C56E1","#B04AFF","#97EDDB","#92C8FF")
    # Expl_HighCont <- c("#2D2669","#FF4A1B","#18CDFF","#E8E126","#BF00B5","#5EB17D")
    # all in stored in `data/`

    # ensure the chosen colour palette is one of the Explorisitcs palettes
    colourPalette <-
      match.arg(colour_pal,
                choices = c("Expl_Blue", "Expl_External", "Expl_HighCont"))


    ## function to remove "as.factor()" or "as.character(as.numeric())" from labels
    # e.g. "as.factor(cyl)" becomes "cyl"
    clean_label <- function(x) {
      x <- sub(".*\\((.*?)\\).*", "\\1", x)
      return(x)
    }

    # work out number of colours needed for colour
    colour_var <- as_label(plot$mapping$colour)

    # if as.*() used set it to that function, else use the type of colour variable
    if (grepl("as.*)$", colour_var) == TRUE) {
      # find function applied
      func_colour <- sub("^as.(\\w+)\\(.*$", "\\1", colour_var)
      # clean the name
      colour_var <- clean_label(colour_var)
      # use the function as the class
      colour_class <- func_colour
    } else{
      colour_class <- class(unlist(plot$data[colour_var]))
    }


    # discrete or continuous functions needed?
    if (colour_class %in% c("logical", "character", "factor", "ordered")) {
      # discrete
      colour_num <- length(unique(unlist(plot$data[colour_var])))

      # use specified colours from palette if 6 or less needed.
      # create colorRampPalette if >6 needed.
      if (colour_num <= 6) {
        plot <-
          plot + scale_color_manual(values = get(colourPalette)[1:colour_num])

      } else{
        plot <-
          plot + scale_color_manual(values = grDevices::colorRampPalette(get(colourPalette))(colour_num))

      }

    } else{
      if (rev_gradient == TRUE) {
        # continuous
        if (colourPalette == "Expl_Blue") {
          plot <- plot + scale_color_gradientn(colours = rev(Expl_Blue))
        }
        if (colourPalette == "Expl_External") {
          plot <-
            plot + scale_color_gradientn(colours = rev(Expl_External[c(1, 6, 2)]))
        }
        if (colourPalette == "Expl_HighCont") {
          plot <-
            plot + scale_color_gradientn(colours = rev(Expl_HighCont[c(1, 2, 4)]))
        }
      } else{
        # continuous
        if (colourPalette == "Expl_Blue") {
          plot <- plot + scale_color_gradientn(colours = Expl_Blue)
        }
        if (colourPalette == "Expl_External") {
          plot <-
            plot + scale_color_gradientn(colours = Expl_External[c(1, 6, 2)])
        }
        if (colourPalette == "Expl_HighCont") {
          plot <-
            plot + scale_color_gradientn(colours = Expl_HighCont[c(1, 2, 4)])
        }
      }

    }

    return(plot)

  }
