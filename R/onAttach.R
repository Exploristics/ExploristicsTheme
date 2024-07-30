# On loading package set the theme as Exploristics Theme

.onAttach <- function(pkgname, libname) {
  theme_set(exploristics_theme())

  options(
    ggplot2.discrete.colour = ExploristicsTheme::Expl_Brand[c(1, 7, 4, 2, 5, 3, 6)],
    ggplot2.discrete.fill = ExploristicsTheme::Expl_Brand[c(1, 7, 4, 2, 5, 3, 6)],
    ggplot2.continuous.colour = scale_colour_exploristics,
    ggplot2.continuous.fill = scale_fill_exploristics
  )
}
