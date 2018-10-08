getInfoDevice <- function(token)
{
   return(
      httr::GET(url = "https://data.qivivo.com/api/v2/devices",
                httr::accept_json(),
                httr::add_headers(Authorization = sprintf("Bearer %s",token$credentials$access_token)),
                config = list(token = token))
   )
}
