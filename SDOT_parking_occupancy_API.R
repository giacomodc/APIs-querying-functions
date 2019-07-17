
#2018 Paid parking occupancy API - Seattle Department of Transportation (https://dev.socrata.com/foundry/data.seattle.gov/6yaw-2m8q)
sdotpark_api <- function(mysegment, from, to, at) {
  ##INPUTs examples:
  # mysegment = "3RD AVE BETWEEN CLAY ST AND BROAD ST" (see https://data.seattle.gov/Transportation/Seattle-Streets/jc8u-fewc for street segment names)
  # from      = "2018-10-03 08:52:55" (observed occupancy between timestamp "from" and timestamp "to")
  # to        = "2018-10-03 08:52:55" (observed occupancy between timestamp "from" and timestamp "to")
  # at        = "2018-10-03 08:52:55" (observed occupancy at timestamp "at")
  
  mysegment <- as.character(mysegment)
  
  if (!is.na(from) & !is.na(to)) {
    from <- gsub(" ", "T", as.character(from))
    to <- gsub(" ", "T", as.character(to))
    url = paste0("https://data.seattle.gov/resource/6yaw-2m8q.json?", 
                 "blockfacename=",
                 mysegment,
                 "&$where=occupancydatetime between '",
                 from,
                 "' and '",
                 to,
                 "'",
                 "&$$app_token=1o8pxSo2iBUkrrzBo8obeVEQx",
                 "&$limit=1000000")
  }
  if (!is.na(at)) {
    at <- gsub(" ", "T", as.character(at))
    at <- gsub("[0-9][0-9]$","00",at) #round to minute
    url = paste0("https://data.seattle.gov/resource/6yaw-2m8q.json?", 
                 "blockfacename=",
                 mysegment,
                 "&occupancydatetime=",
                 at,
                 "&$$app_token=1o8pxSo2iBUkrrzBo8obeVEQx",
                 "&$limit=1000000")
  }
  url <- URLencode(url)
  ll <- fromJSON(getURL(url))
  if (length(ll)==0) return(NA) else return(ll)

}


