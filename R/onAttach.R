# On loading package set the theme as Exploristics Theme

.onAttach <- function(libname, pkgname) {
  theme_set(exploristics_theme())
  options(ggplot2.discrete.colour = ExploristicsTheme::Expl_Rebrand,
          ggplot2.discrete.fill = ExploristicsTheme::Expl_Rebrand,
          ggplot2.continuous.colour = scale_colour_exploristics,
          ggplot2.continuous.fill = scale_fill_exploristics)
}
