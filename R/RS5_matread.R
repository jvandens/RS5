library(mapview)

file <- "C:/Users/jvandens/Downloads/01-Transect_20221123090339.mat"

sf <- get_RS5transect(file)

mapview(df, zcol = "BT_Depth_VB")


