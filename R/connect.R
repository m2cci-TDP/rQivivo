#' Title
#'
#' @param appName TODO
#' @param clientID TODO
#' @param secretID TODO
#' @param redirectURI TODO
#'
#' @return TODO
#' @export
connect <- function(appName = "QivivoTheo",
                    clientID = "DMZEHQiwDg0UuhWNn1M7lCjjxoxmDqKxfZnl86rU",
                    secretID = "2UefAS8Qf9pFvKndoXXNHWZuoURfAe2lztm5vssJIMUnjlUBlL",
                    redirectURI = "http://127.0.0.1:1410")
{
   return(
      httr::oauth2.0_token(endpoint = httr::oauth_endpoint(request = NULL,
                                                           authorize = "https://account.qivivo.com",
                                                           access = "https://account.qivivo.com/oauth/token"),
                           app = httr::oauth_app(appname = appName,
                                                 key = clientID,
                                                 secret = secretID,
                                                 redirect_uri = redirectURI),
                           use_basic_auth = TRUE,
                           as_header = TRUE,
                           client_credentials = FALSE,
                           use_oob = FALSE,
                           cache = FALSE,
                           scope = "user_basic_information read_devices read_thermostats read_wireless_modules read_programmation update_programmation read_house_data update_house_settings")# update_thermostat")
   )
}
