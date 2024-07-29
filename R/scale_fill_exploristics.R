#' @title Exploristics Gradient fill scales
#' @seealso \code{\link[ggplot2]{scale_color_gradient}}
#' @param ... Arguments passed to \code{\link[ggplot2]{scale_color_gradient}}
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(x = wt, y = wt)) +
#'  geom_point(aes(colour = gear)) +
#'  scale_fill_exploristics()

scale_fill_exploristics <- function(...){
  scale_fill_gradient(low = Expl_Rebrand[2], high = Expl_Rebrand[1], na.value = Expl_Rebrand[4], ...)
}
