#' @title Exploristics Gradient colour scales
#' @author Gareth Burns
#' @param ... Additional arguments passed to
#' \code{\link[ggplot2]{scale_color_gradient}}
#' @description
#' A two colour gradient for continuous variables
#' @seealso \code{\link[ggplot2]{scale_color_gradient}}
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(data = mtcars, aes(x = mpg, y = hp, colour = mpg)) +
#' geom_point() +
#' scale_colour_exploristics()


scale_colour_exploristics <- function(...) {
  scale_color_gradient(low = Expl_Brand[2],
                       high = Expl_Brand[1],
                       na.value = Expl_Brand[7],
                       ...)
}
