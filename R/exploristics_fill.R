#' Add Exploristics fill to ggplot chart
#'
#' This function allows you to add the Exploristics fill to your ggplotgraphics.
#' This function sets the fill of the graphs to a gradient matching the exploristics colour scheme
#' @keywords exploristics_fill
#' @export
exploristics_fill = function(){
  scale_fill_brewer(palette = 'GnBu', direction = -1)
}
