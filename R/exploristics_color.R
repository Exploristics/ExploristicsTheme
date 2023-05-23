#' @title Add Exploristics colour to ggplot2 figure.
#' @description This function allows you to add the Exploristics colour to your
#'   \code{ggplot2} figure.
#' @details This function sets the colour of the graphs to a gradient matching
#'   the Exploristics colour scheme.
#' @param \code{dots} Additional arguments passed to \code{\link[ggplot2]{scale_color_brewer}}
#' @seealso \code{\link[ggplot2]{scale_color_brewer}}
#' @import 'ggplot2'
#' @export

exploristics_color = function(...){
  scale_color_brewer(palette = "GnBu", direction = -1L, ...)
}
