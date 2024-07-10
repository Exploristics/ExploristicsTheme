#' @title Add Exploristics theme to ggplot2 figure.
#' @description This function allows you to add the Exploristics theme to a ggplot2 figure.
#' @author Amy McCorry
#' @details This function is added to your ggplot to set elements of the \code{`theme()`}
#'  including background, axis, legend and titles to the style used at Exploristics.
#' @param base_size base font size, given in pts.
#' @param base_family	base font family
#' @param base_line_size base size for line elements
#' @param base_rect_size base size for rect elements
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


exploristics_theme <-
  function(base_size = 12,
           base_family = "",
           base_line_size = base_size / 11,
           base_rect_size = base_size / 11) {
    font <- "sans"

    # most of the theme is created here
    expl_theme <-
      # Using replace to ensure if future theme arguments are added
      # they default to theme_minimal
      theme_minimal(
        base_size = base_size,
        base_family = base_family,
        base_line_size = base_line_size,
        base_rect_size = base_rect_size
      ) %+replace%
      theme(
        text = element_text(color = Text_Colour),
        line = element_line(color = Text_Colour),
        # Text format:
        # This sets the font, size, type and colour of text for the chart's title
        plot.title = element_text(
          family = font,
          size = ceiling(base_size * 1.6667),
          color = Text_Colour,
          hjust = 0.5
        ),
        # This sets the font, size, type and colour of text for the chart's
        # subtitle, as well as setting a margin between the title and the subtitle
        plot.subtitle = element_text(
          family = font,
          colour = ExploristicsTheme::Expl_Rebrand[2],
          size = ceiling(base_size * 1.333),
          margin = margin(9, 0, 9, 0),
          hjust = 0.5
        ),
        plot.caption = element_text(colour = ExploristicsTheme::Expl_Rebrand[4],
                                    hjust = 1.0),
        plot.caption.position = "plot",
        # Legend format
        # This sets the position and alignment of the legend, removes a title and
        # background for it and sets the requirements for any text within the
        # legend. The legend may often need some more manual tweaking when it
        # comes to its exact position based on the plot coordinates.
        legend.position = "right",
        legend.background = element_blank(),
        legend.title =     element_text(
          family = font,
          size = ceiling(base_size * 1.5),
          color = Text_Colour
        ),
        legend.key = element_blank(),
        legend.text = element_text(
          family = font,
          size = ceiling(base_size * 1.5),
          color = Text_Colour,
          hjust = 0
        ),

        # Axis format
        # This sets the text font, size and colour for the axis test, as well as
        # setting the margins and removes lines and ticks. In some cases, axis
        # lines and axis ticks are things we would want to have in the chart
        # - the cookbook shows examples of how to do so.
        axis.title = element_text(
          family = font,
          size = ceiling(base_size * 1.5),
          color = Text_Colour
        ),
        axis.text = element_text(
          family = font,
          size = ceiling(base_size * 1.5),
          color = Text_Colour
        ),
        axis.text.x = element_text(margin = margin(5, b = 10)),


        ## Note, how axis line elements are set is conditional on the ggplot2
        ## version in the `conditional_theme` vars below ##

        # Grid lines
        # This removes all minor gridlines and adds major y gridlines. In many
        # cases you will want to change this to remove y gridlines and add x
        # gridlines. The cookbook shows you examples for doing so
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),



        # Blank background
        # This sets the panel background as blank, removing the standard grey
        # ggplot background colour from the plot
        panel.background = element_blank(),

        # Strip background (#This sets the panel background for facet-wrapped plots
        # to white, removing the standard grey ggplot background colour and sets
        # the title size of the facet-wrap title to font size 22)
        strip.background = element_rect(fill = Backgroud_Colour),
        strip.text = element_text(size  = ceiling(base_size * 1.6667),  hjust = 0),

        axis.ticks = element_line(colour = Tick_Colour,
                                  linewidth = ceiling(base_size / 20)),
        axis.line = element_line(colour = Tick_Colour,
                                 linewidth = ceiling(base_size / 20))
      )
    return(expl_theme)
  }

#' @title Add Exploristics theme to ggplot2 figure.
#' @description A \code{\link[ExploristicsTheme]{exploristics_theme}} function but
#'   starting with \code{theme} naming convention.
#' @author Gareth Burns
#' @details The \code{theme_} prefix is required for use in KerusCloud VPV and
#'   having both \code{\link[ExploristicsTheme]{theme_exploristics}} and
#'   \code{\link[ExploristicsTheme]{exploristics_theme}} maintains backwards compatibility
#' @param base_size base font size, given in pts.
#' @param base_family	base font family
#' @param base_line_size base size for line elements
#' @param base_rect_size base size for rect elements
#' @seealso \code{\link[ggplot2]{theme}}
#' @import 'ggplot2'
#' @export

theme_exploristics <-  function(base_size = 12,
                                base_family = "",
                                base_line_size = base_size / 11,
                                base_rect_size = base_size / 11) {
  do.call("exploristics_theme", args = as.list(environment(), all = TRUE))

}
