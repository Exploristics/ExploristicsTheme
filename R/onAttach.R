# On loading package set the theme as Exploristics Theme

.onAttach <- function(pkgname, libname) {
  theme_set(theme_exploristics())

  # grDevices::colorRampPalette(get("Expl_Rebrand"))(9)

  options(ggplot2.discrete.colour = ExploristicsTheme::Expl_Rebrand,
          ggplot2.discrete.fill = ExploristicsTheme::Expl_Rebrand)
          # ggplot2.continuous.colour = )
}
