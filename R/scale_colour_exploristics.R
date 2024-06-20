#' @title Exploristics Gradient colour scales
#' @seealso \code{\link[ggplot2]{scale_color_gradient}}
#' @export
#' @examples


scale_colour_exploristics <- function() {
  scale_color_gradient(low = Expl_Rebrand[2],
                       high = Expl_Rebrand[1],
                       na.value = Expl_Rebrand[4])
}
