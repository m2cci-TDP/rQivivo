PostTemperature <- function(token, UUID, temperature = 20, duration = 20)
{
   return(
      httr::POST(url = sprintf("https://data.qivivo.com/api/v2/devices/thermostats/%s/temperature/temporary-instruction", UUID),
                 body = list(temperature =  temperature,
                             duration = duration),
                 httr::accept_json(),
                 httr::add_headers(Authorization = sprintf("Bearer %s",token$credentials$access_token)),
                 config = list(token = token))
   )
}
