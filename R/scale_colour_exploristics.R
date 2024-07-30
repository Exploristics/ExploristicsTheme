#' @title Exploristics Gradient colour scales
#' @seealso \code{\link[ggplot2]{scale_color_gradient}}
#' @export
#' @examples


scale_colour_exploristics <- function(...) {
  scale_color_gradient(low = Expl_Brand[2],
                       high = Expl_Brand[1],
                       na.value = Expl_Brand[7],
                       ...)
}
