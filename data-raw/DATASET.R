## code to prepare `DATASET` dataset goes here

# colour palettes
Expl_RGB <- c(
  "#6b89e3", "#d8807f", "#d7f67c", "#6ddabf", "#9eb7de", "#f6c0ad"
)
Expl_RGB_dark <- c(
  "#576fb8", "#ae6867", "#b1ca65", "#4c9d88", "#7f93b3", "#ca9e8e"
)
Expl_Mono <- c(
  "#121a31", "#16213d", "#2d3750", "#5c6477", "#ecf1f8", "#ffffff"
)


Expl_Rebrand <- c(
  "#16213D", "#A1B9E0", "#6B8BE5", "#DA8280"
)
Expl_Blue <-
  c("#002659",
    "#293D94",
    "#136BBA",
    "#16A4D4",
    "#9DD6E4",
    "#D6EFF5")
Expl_External <-
  c("#7119A2",
    "#28CAAB",
    "#3C56E1",
    "#B04AFF",
    "#97EDDB",
    "#92C8FF")
Expl_HighCont <-
  c("#2D2669",
    "#FF4A1B",
    "#18CDFF",
    "#E8E126",
    "#BF00B5",
    "#5EB17D")

GradientLUT <- c(Expl_RGB = c(1, 4, 2),
                 Expl_RGB_dark = c(1, 4, 2),
                 Expl_Mono = c(5, 3, 2),
                 Expl_Rebrand = c(1,2),
                 Expl_Blue = seq(length(Expl_Blue)),
                 Expl_External = c(1, 6, 2),
                 Expl_HighCont = c(1, 2, 4))

Text_Colour <- Expl_Rebrand[1]
Footer_Text_Colour <- Expl_Rebrand[3]
Line_Colour <- Expl_Rebrand[2]
Tick_Colour <- Expl_Rebrand[1]
Backgroud_Colour <- "#FFFFFF"

usethis::use_data(Expl_RGB,
                  Expl_RGB_dark,
                  Expl_Mono,
                  Expl_Rebrand,
                  Expl_Blue,
                  Expl_External,
                  Expl_HighCont,
                  overwrite = TRUE)

usethis::use_data(
  GradientLUT,
  Text_Colour,
  Footer_Text_Colour,
  Line_Colour,
  Tick_Colour,
  Backgroud_Colour,
  internal = TRUE,
  overwrite = TRUE
)
