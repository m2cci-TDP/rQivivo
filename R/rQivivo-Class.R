#### Génériques ####
methods::setGeneric(name = "refresh",
                    def = function(object)
                    {
                       standardGeneric("refresh")
                    })
methods::setGeneric(name = "getThermostat",
                    def = function(object, type)
                    {
                       standardGeneric("getThermostat")
                    })
methods::setGeneric(name = "absence",
                    def = function(object, request, body)
                    {
                       standardGeneric("absence")
                    })
#### Classe ####
methods::setOldClass("Token2.0")
methods::setClass(Class = "rQivivo",
                  representation = methods::representation(token = "Token2.0",
                                                           UUID = "character")
)

#### Constructeur ####
connect <- function(appName, clientID, secretID, redirectURI)
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
                                                                             object@token$credentials$token_type,
                                                                             token$credentials$access_token)),
                                   config = list(token = token)))$devices[[1]]$uuid

   return(
      methods::new(Class = "rQivivo", token = token, UUID = UUID)
   )
}

#### Impression ####
methods::setMethod(f = "show",
                   signature = "rQivivo",
                   definition = function(object)
                   {
                      cat("An object of class \"rQvivio\"\n")
                      cat("Authentification by OAuth 2.0 with httr package\n")
                      print(object@token)
                      cat("Thermostat UUID : ",object@UUID,"\n")
                   })


#### refresh token ####
methods::setMethod(f = "refresh",
                   signature = "rQivivo",
                   definition = function(object)
                   {
                      objectName <- deparse(substitute(object))
                      response <- httr::POST(url = "https://account.qivivo.com/oauth/token",
                                             query = list(grant_type = "refresh_token",
                                                          refresh_token = object@token$credentials$refresh_token,
                                                          client_id = object@token$app$key))
                      switch (EXPR = as.character(httr::status_code(response)),
                              "200" = {
                                 object@token$credentials <- httr::content(response)
                                 assign(objectName, object, envir = parent.frame())
                              },
                              "401" = {
                                 stop("Echec, veuillez recharger la page...")
                              },
                              stop("Echec, veuillez recharger la page..."))

                      return(invisible())
                   })

#### get thermostat ####
methods::setMethod(f = "getThermostat",
                   signature = "rQivivo",
                   definition = function(object, type)
                   {
                      if (all(type != c("info", "temperature", "humidity", "presence")) || length(type) != 1)
                      {
                         stop("L'argument \"type\" ne peut prendre comme valeur seulement \"info\", \"temperature\", \"humidity\" ou \"presence\"")
                      }
                      response <- httr::GET(url = sprintf("https://data.qivivo.com/api/v2/devices/thermostats/%s/%s",
                                                          object@UUID, type),
                                            httr::accept_json(),
                                            httr::add_headers(Authorization = sprintf("%s %s",
                                                                                      object@token$credentials$token_type,
                                                                                      object@token$credentials$access_token)),
                                            config = list(token = object@token))
                      return(httr::content(response))
                   })

#### absence ####
methods::setMethod(f = "absence",
                   signature = "rQivivo",
                   definition = function(object, request = c("post","del"), body = list())
                   {
                      switch(EXPR = request,
                             "post" = {
                                if (any(names(body) != c("start_date","end_date")))
                                {
                                   stop("\"body\" est une liste comportant 2 slots \"start_date\" et \"end_date\"")
                                }
                                else
                                {
                                   if (!inherits(body$start_date, "POSIXt"))
                                   {
                                      stop("\"body$start_date\" doit être de classe \"POSIXt\"")
                                   }
                                   if (!inherits(body$end_date, "POSIXt"))
                                   {
                                      stop("\"body$end_date\" doit être de classe \"POSIXt\"")
                                   }
                                }

                                response <- httr::POST(url = sprintf("https://data.qivivo.com/api/v2/devices/thermostats/%s/absence",
                                                                     object@UUID),
                                                       body = body,
                                                       httr::accept_json(),
                                                       httr::add_headers(Authorization = sprintf("%s %s",                                                                                      object@token$credentials$token_type,
                                                                                                 object@token$credentials$token_type,
                                                                                                 object@token$credentials$access_token)),
                                                       config = list(token = object@token))
                             },
                             "del" = {
                                response <- httr::DELETE(url = sprintf("https://data.qivivo.com/api/v2/devices/thermostats/%s/absence",
                                                                       object@UUID),
                                                         httr::accept_json(),
                                                         httr::add_headers(Authorization = sprintf("%s %s",                                                                                      object@token$credentials$token_type,
                                                                                                   object@token$credentials$token_type,
                                                                                                   object@token$credentials$access_token)),
                                                         config = list(token = object@token))
                             },
                             stop("\"request\" ne peut prendre que les valeurs \"post\" ou \"del\""))

                      if (httr::status_code(response) == 200)
                      {
                         message(httr::content(response)$message)
                      }
                      else
                      {
                         stop("Echec, veuillez recharger la page...")
                      }
                   })
