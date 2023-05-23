#' @title Add Exploristics fill to ggplot2 figure.
#' @description This function allows you to add the Exploristics fill to your
#'   ggplot figure.
#' @details This function sets the fill of the graphs to a gradient matching the
#'   Exploristics colour scheme.
#' @param \code{dots} Additional arguments passed to \code{\link[ggplot2]{scale_fill_brewer}}
#' @seealso \code{\link[ggplot2]{scale_fill_brewer}}
#' @import 'ggplot2'
#' @export

exploristics_fill = function(...){
  scale_fill_brewer(palette = "GnBu", direction = -1L, ...)
}
