getTemperature <- function(token, UUID)
{
   return(
      httr::GET(url = sprintf("https://data.qivivo.com/api/v2/devices/thermostats/%s/temperature", UUID),
                httr::accept_json(),
                httr::add_headers(Authorization = sprintf("Bearer %s",token$credentials$access_token)),
                config = list(token = token))
   )
}
