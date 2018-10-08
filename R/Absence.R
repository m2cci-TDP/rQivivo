#' Title
#'
#' @param token TODO
#' @param UUID TODO
#' @param startDate TODO
#' @param endDate TODO
#' @param fmt TODO
#' @param tz TODO
#'
#' @return TODO
#' @export
PostAbsence <- function(token, UUID, startDate, endDate, fmt = "%Y-%m-%d %H:%M", tz = "UTC")
{
   startDate <- as.POSIXct(x = startDate,
                           tz = tz,
                           format = fmt)
   endDate <- as.POSIXct(x = endDate,
                         tz = tz,
                         format = fmt)
   return(
      httr::POST(url = sprintf("https://data.qivivo.com/api/v2/devices/thermostats/%s/absence", UUID),
                 body = list(start_date =  startDate,
                             end_date = endDate),
                 httr::accept_json(),
                 httr::add_headers(Authorization = sprintf("Bearer %s",token$credentials$access_token)),
                 config = list(token = token))
   )
}

DelAbsence <- function(token, UUID)
{
   return(
      httr::DELETE(url = sprintf("https://data.qivivo.com/api/v2/devices/thermostats/%s/absence", UUID),
                   httr::accept_json(),
                   httr::add_headers(Authorization = sprintf("Bearer %s",token$credentials$access_token)),
                   config = list(token = token))
   )
}
