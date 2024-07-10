#' @title Function to run on loading package
#' @author Gareth Burns
#' @description
#' When a user loads the ExploristicsTheme package this function is ran to
#' apply the exploristics_theme by default and use Exploristics colour palettes.
#' @noRd

ExecuteOnAttach <- function() {
  theme_set(exploristics_theme())
  options(ggplot2.discrete.colour = ExploristicsTheme::Expl_Rebrand,
          ggplot2.discrete.fill = ExploristicsTheme::Expl_Rebrand,
          ggplot2.continuous.colour = scale_colour_exploristics,
          ggplot2.continuous.fill = scale_fill_exploristics)
}
