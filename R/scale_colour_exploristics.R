#' @title Exploristics Gradient colour scales
#' @author Gareth Burns
#' @param ... Arguments passed to \code{\link[ggplot2]{scale_color_gradient}}
#' @seealso \code{\link[ggplot2]{scale_color_gradient}}
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(x = wt, y = wt)) +
#'  geom_point(aes(colour = qsec)) +
#'  scale_colour_exploristics()


scale_colour_exploristics <- function(...) {
  scale_color_gradient(low = ExploristicsTheme::Expl_Rebrand[2],
                       high = ExploristicsTheme::Expl_Rebrand[1],
                       na.value = ExploristicsTheme::Expl_Rebrand[4],
                       ...)
}
