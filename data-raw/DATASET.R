## code to prepare `DATASET` dataset goes here

# colour palettes
Expl_Brand <- c(
  "#121a31",
  "#2d3750",
  "#cfdbef",
  "#6ddabf",
  "#4c9d88",
  "#ae6867",
  "#d8807f",
  "#ca9e8e",
  "#f6c0ad",
  "#b1ca65",
  "#d7f67c",
  "#576fb8"
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

GradientLUT <- c(
  Expl_Brand = c(1, 2),
  Expl_Blue = seq(length(Expl_Blue)),
  Expl_External = c(1, 6, 2),
  Expl_HighCont = c(1, 2, 4)
)

Text_Colour <- Expl_Brand[1]
Footer_Text_Colour <- Expl_Brand[7]
Line_Colour <- Expl_Brand[2]
Tick_Colour <- Expl_Brand[1]
Backgroud_Colour <- "#FFFFFF"

usethis::use_data(Expl_Brand,
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
