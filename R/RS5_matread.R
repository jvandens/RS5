library(mapview)

# source the function
source("./R/get_RS5transect.R")

file <- "./data/01-Transect_20221123090339.mat"

sf <- get_RS5transect(file)

# plot
mapview(sf, zcol = "BT_Depth_VB")

# save
sf::st_write(sf, "./output/transect.gpkg")

