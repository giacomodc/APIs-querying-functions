

google_api <- function(origin, destination, departure_time, traffic_model, KEY) {
  ##INPUTs example:
  # origin="47.667830,-122.312795" (lat, lon)
  # destination="47.667830,-122.312795" (lat, lon)
  # departure_time=1560358800 (UNIX time)
  # traffic_model="pessimistic" (other options are optimistic, best_guess)
  
  if (is.na(origin)|is.na(destination)|is.na(departure_time)) return(NA)
  
  # send query to distance matrix API
  resp <- GET("https://maps.googleapis.com/maps/api/distancematrix/json",
              query = list(
                origins = origin,
                destinations = destination,
                departure_time=departure_time,
                traffic_model=traffic_model,
                key=KEY)
  )
  # format to R dataframe
  parsed <- fromJSON(content(resp, "text"), simplifyDataFrame = T)
  # output
  #if (http_error(resp)) return(parsed$error_message) # CHECK
  return(data.frame("address"=parsed$destination_addresses,
                    "duration"=parsed$rows$elements[[1]]$duration$value,
                    "duration_in_traffic"=parsed$rows$elements[[1]]$duration_in_traffic$value,
                    "distance"=parsed$rows$elements[[1]]$distance$value,
                    "status"=parsed$rows$elements[[1]]$status, stringsAsFactors = F)
  )
}


# compute number of seconds that have elapsed since 00:00:00 Thursday, 1 January 1970, Coordinated Universal Time (UTC)
calculate_unix_time <- function(date, time) {
  ##INPUTs examples
  # date=2019-06-12
  # time=18:00:00
  return(as.numeric(strptime(paste(date, time),  "%Y-%m-%d %H:%M:%S")))
}



