#' Reformat ERA5 weather dataframe list
#'
#' Converts temp variables from K to C. Derives wind speed from wind u- and
#' v-components.
#'
#' @param data List of ERA5 weather data dataframes
#' @return A list of reformatted dataframes
#' @export
reformat_ERA_data <- function(data) {
  drops <- c("mx2t","mn2t", "d2m", "t2m", "tp", "ssrd", "u10", "v10")
  for (x in seq_len(length(data))) {
    data[[x]]$tmax <- drop_units(data[[x]]$mx2t) - 273.15
    data[[x]]$tmin <- drop_units(data[[x]]$mn2t) - 273.15
    data[[x]]$tdew <- drop_units(data[[x]]$d2m) - 273.15
    data[[x]]$tavg <- drop_units(data[[x]]$t2m)
    data[[x]]$prcp <- drop_units(data[[x]]$tp)
    data[[x]]$srad <- drop_units(data[[x]]$ssrd)
    data[[x]]$wind <- sqrt(drop_units(data[[x]]$u10)^2 + drop_units(data[[x]]$v10)^2)
  }
  data <- lapply(data, function(x) x[!(names(x) %in% drops)])
  return(data)
}