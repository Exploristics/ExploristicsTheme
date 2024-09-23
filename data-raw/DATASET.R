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

Text_Colour <- Expl_Brand[1]
Footer_Text_Colour <- Expl_Brand[7]
Line_Colour <- Expl_Brand[2]
Tick_Colour <- Expl_Brand[1]
Backgroud_Colour <- "#FFFFFF"

usethis::use_data(Expl_RGB,
                  Expl_RGB_dark,
                  Expl_Mono,
                  Expl_Brand,
                  overwrite = TRUE)

usethis::use_data(
  Text_Colour,
  Footer_Text_Colour,
  Line_Colour,
  Tick_Colour,
  Backgroud_Colour,
  internal = TRUE,
  overwrite = TRUE
)
