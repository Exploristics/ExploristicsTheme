#' @title Add Exploristics theme to ggplot2 figure.
#' @description This function allows you to add the Exploristics theme to a ggplot2 figure.
#' @details This function is added to your ggplot to set elements of the `theme()` including background,
#' axis, legend and titles to the style used at Exploristics.
#' @param axis_lines Add x- and y-axis lines to the plot. Defaults to `TRUE`.
#' @param grid_lines Add major grid lines to the plot. Defaults to `FALSE`.
#' @param legend Display plot legend. Defaults to `TRUE`.
#' @param legend_side Position the legend to the right side id `TRUE` or the bottom of the plot if `FALSE`. Defaults to `TRUE`.
#' @param legend_title Display legend title. Defaults to `TRUE`.
#' @param title_size Font size for the plot title. Defaults to 20.
#' @param subtitle_size Font size for the plot subtitle. Defaults to 16.
#' @param axis_title_size Font size for the plot x- and y-axis titles. Defaults to 18.
#' @param axis_size Font size for the plot axis tick labels. Defaults to 18.
#' @seealso \code{\link[ggplot2]{theme}}
#' @import 'ggplot2'
#' @export
#' @examples
#' library(ggplot2)
#'
#' ## generate a plot and add the Exploristics theme
#' ggplot(data = mtcars, aes(x = hp, y = mpg)) +
#' geom_point() +
#' exploristics_theme()


exploristics_theme <- function(axis_lines=T,grid_lines=F,legend=T,legend_side=T,legend_title=T,title_size=20,subtitle_size=16,axis_title_size=18,axis_size=18) {

  font <- "sans"

  theme(
    #Text format:
    #This sets the font, size, type and colour of text for the chart's title
    plot.title = element_text(
      family = font,
      size = title_size,
      color = "#121037",
      hjust = 0.5
    ),
    #This sets the font, size, type and colour of text for the chart's subtitle, as well as setting a margin between the title and the subtitle
    plot.subtitle = element_text(
      family = font,
      size = subtitle_size,
      margin = margin(9, 0, 9, 0),
      hjust = 0.5
    ),
    plot.caption = element_blank(),
    #This leaves the caption text element empty

    #Legend format
    #This sets the position and alignment of the legend, removes a title and background for it and sets the requirements for any text within the legend. The legend may often need some more manual tweaking when it comes to its exact position based on the plot coordinates.
    legend.position = ifelse(legend, ifelse(legend_side, "right", "bottom"),element_blank()),
    legend.text.align = 0,
    legend.background = element_blank(),
    legend.title = if(legend_title) element_text(family = font, size = axis_size, color = "#121037") else element_blank(),
    legend.key = element_blank(),
    legend.text = element_text(
      family = font,
      size = axis_title_size,
      color = "#121037"
    ),

    #Axis format
    #This sets the text font, size and colour for the axis test, as well as setting the margins and removes lines and ticks. In some cases, axis lines and axis ticks are things we would want to have in the chart - the cookbook shows examples of how to do so.
    axis.title = element_text(
      family = font,
      size = axis_title_size,
      color = "#121037"
    ),
    axis.text = element_text(
      family = font,
      size = axis_size,
      color = "#121037"
    ),
    axis.text.x = element_text(margin = margin(5, b = 10)),


    axis.ticks = if(axis_lines) element_line(colour="black", lwd = 1.05) else element_blank(),
    axis.line = if(axis_lines) element_line(colour="black", lwd = 1.05) else element_blank(),


    #Grid lines
    #This removes all minor gridlines and adds major y gridlines. In many cases you will want to change this to remove y gridlines and add x gridlines. The cookbook shows you examples for doing so
    panel.grid.minor = element_blank(),
    panel.grid.major.y = if(grid_lines) element_line(color = "#A2D7E4") else element_blank(),
    panel.grid.major.x = if(grid_lines) element_line(color = "#A2D7E4") else element_blank(),

    #Blank background
    #This sets the panel background as blank, removing the standard grey ggplot background colour from the plot
    panel.background = element_blank(),

    #Strip background (#This sets the panel background for facet-wrapped plots to white, removing the standard grey ggplot background colour and sets the title size of the facet-wrap title to font size 22)
    strip.background = element_rect(fill = "white"),
    strip.text = element_text(size  = title_size,  hjust = 0)
  )

}

