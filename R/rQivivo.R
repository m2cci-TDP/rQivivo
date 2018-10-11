#' @name rQivivo
#' @title rQivivo object constructor
#' @description The function is the constructor of rQivivo class. See \url{https://account.qivivo.com/}.
#'
#' @param appName character: (optional) name of the private API.
#' @param clientID character: client ID of the private API.
#' @param secretID character: secret ID of the private API.
#' @param redirectURI character: redirected URI of the private API. Use locate IP for RStudio.
#'
#' @return The function returns an rQivivo object.
#' @export
#' @rdname rQivivo
#' @author Theo DEVAUCOUP \email{theo.devaucoup@@pm.me}
rQivivo <- function(appName, clientID, secretID, redirectURI)
{
   token <- httr::oauth2.0_token(endpoint = httr::oauth_endpoint(request = NULL,
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
                                 scope = paste(c("user_basic_information","read_devices","read_thermostats","read_wireless_modules",
                                                 "read_programmation","update_programmation","read_house_data","update_house_settings"),
                                               collapse = " "))# update_thermostat")

   UUID <- httr::content(httr::GET(url = "https://data.qivivo.com/api/v2/devices",
                                   httr::accept_json(),
                                   httr::add_headers(Authorization = sprintf("%s %s",
                                                                             token$credentials$token_type,
                                                                             token$credentials$access_token)),
                                   config = list(token = token)))$devices[[1]]$uuid

   return(
      methods::new(Class = "rQivivo",
                   token = token,
                   UUID = UUID,
                   badConnection = simpleError(message = "Bad connection, reload the page...",
                                               call = "badConnection"))
   )
}
