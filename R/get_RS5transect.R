get_RS5transect <- function(file) {
  
  require(R.matlab)
  require(sf)
  
  # read in our data
  matfile <- readMat(file)
  
  # SiteInfo
  site <- unlist(matfile[["SiteInfo"]][[1]])
  station <- unlist(matfile[["SiteInfo"]][[2]])
  loc <- unlist(matfile[["SiteInfo"]][[3]])
  op <- unlist(matfile[["SiteInfo"]][[4]])
  meas_num <- unlist(matfile[["SiteInfo"]][[6]])
  
  # General
  gen_samplenum <- data.frame(matfile[["General"]][[2]])
  gen_time <- data.frame(unlist(matfile[["General"]][[3]]))
  gen_type <- data.frame(unlist(matfile[["General"]][[4]]))
  
  # bottom track
  bot_track_allbeams <- data.frame(matfile[["BottomTrack"]][[1]])
  
  # GPS
  lat <- data.frame(matfile[["GPS"]][[9]])
  lon <- data.frame(matfile[["GPS"]][[10]])
  
  # Summary
  mean_spd <- data.frame(matfile[["Summary"]][[6]])
  mean_vel <- data.frame(matfile[["Summary"]][[7]])
  
  
  # combine and export
  df <- cbind(site, station, loc, op, meas_num,
              gen_samplenum, gen_time, gen_type, 
              lat, lon,
              bot_track_allbeams,
              mean_spd, mean_vel)
  
  names(df) <- c("Site", "Station", "Location", "Operator", "MeasureNumber",
                 "SampleNumber", "SampleTime", "SampleType",
                 "Lat", "Lon",
                 "BT_Depth_Beam1","BT_Depth_Beam2","BT_Depth_Beam3","BT_Depth_Beam4","BT_Depth_VB",
                 "MeanSpeed", "MeanVelocity_X", "MeanVelocity_Y")
  
  # convert to spatial
  sf <- st_as_sf(df,coords = c("Lon", "Lat"), crs = 4326, agr = "constant")
  return(sf)
}