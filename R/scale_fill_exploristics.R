#' @title Exploristics Gradient fill scales
#' @seealso \code{\link[ggplot2]{scale_color_gradient}}
#' @export
#' @examples


scale_fill_exploristics <- function(){
  scale_fill_gradient(low = Expl_Rebrand[2], high = Expl_Rebrand[2], na.value = Expl_Rebrand[4])
}
