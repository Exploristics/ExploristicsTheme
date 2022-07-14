#' Add Exploristics colour to ggplot chart
#'
#' This function allows you to add the Exploristics colour to your ggplotgraphics.
#' This function sets the colour of the graphs to a gradient matching the exploristics colour scheme
#' @keywords exploristics_colour
#' @export

exploristics_color = function(){
  scale_color_brewer(palette = 'GnBu',direction = -1)
}
