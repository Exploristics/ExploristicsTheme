## code to prepare `DATASET` dataset goes here

# colour palettes
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

usethis::use_data(Expl_Blue, Expl_External , Expl_HighCont, overwrite = TRUE)
