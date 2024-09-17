#' @title Exploristics Gradient fill scales
#' @author Gareth Burns
#' @description
#' A two colour gradient for continuous variables to apply to fill aesthetic
#' @param ... Additional arguments passed to
#' \code{\link[ggplot2]{scale_color_gradient}}
#' @seealso \code{\link[ggplot2]{scale_color_gradient}}
#' @param ... Arguments passed to \code{\link[ggplot2]{scale_color_gradient}}
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(data = mtcars, aes(x = wt, y = mpg, size = hp, fill = mpg)) +
#' geom_point(shape = 21) +
#' scale_colour_exploristics()

scale_fill_exploristics <- function(...) {
  scale_fill_gradient(low = Expl_Brand[3],
                      high = Expl_Brand[1],
                      na.value = Expl_Brand[7],
                      ...)
}
