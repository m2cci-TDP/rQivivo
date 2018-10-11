#### Impression ####
methods::setMethod(f = "show",
                   signature = methods::signature(object = "rQivivo"),
                   definition = function(object)
                   {
                      cat("An object of class \"rQvivio\"\n")
                      cat("Authentification by OAuth 2.0 with httr package\n")
                      print(object@token)
                      cat("Thermostat UUID : ",object@UUID,"\n")
                   })

#### refresh token ####
#' @name refresh
#' @include rQivivo-Generics.R
#' @rdname refresh
#' @aliases refresh
methods::setMethod(f = "refresh",
                   signature = methods::signature(object = "rQivivo"),
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
                                 stop(object@badConnection)
                              },
                              stop(object@badConnection))

                      return(invisible())
                   })

#### get thermostat ####
#' @name getThermostat
#' @include rQivivo-Generics.R
#' @rdname getThermostat
#' @aliases getThermostat
methods::setMethod(f = "getThermostat",
                   signature = methods::signature(object = "rQivivo"),
                   definition = function(object, type)
                   {
                      if (all(type != c("info", "temperature", "humidity", "presence")) || length(type) != 1)
                      {
                         stop("\"type\" can only take \"info\", \"temperature\", \"humidity\" or \"presence\" values.")
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
#' @name absence
#' @rdname absence
#' @include rQivivo-Generics.R
#' @aliases absence
methods::setMethod(f = "absence",
                   signature = methods::signature(object = "rQivivo"),
                   definition = function(object, request = c("post","del"), body = list())
                   {
                      switch(EXPR = request,
                             "post" = {
                                if (any(names(body) != c("start_date","end_date")))
                                {
                                   stop("\"body\" must be a list with \"start_date\" and \"end_date\" slots.")
                                }
                                else
                                {
                                   if (!inherits(body$start_date, "POSIXt"))
                                   {
                                      stop("\"body$start_date\" must be \"POSIXt\" class.")
                                   }
                                   if (!inherits(body$end_date, "POSIXt"))
                                   {
                                      stop("\"body$end_date\" must be \"POSIXt\" class.")
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
                             stop("\"request\" can only take \"post\" or \"del\" values."))

                      if (httr::status_code(response) == 200)
                      {
                         message(httr::content(response)$message)
                      }
                      else
                      {
                         stop(object@badConnection)
                      }
                   })

#### arrival ####
#' @name arrival
#' @rdname arrival
#' @include rQivivo-Generics.R
#' @aliases arrival
methods::setMethod(f = "arrival",
                   signature = methods::signature(object = "rQivivo"),
                   definition = function(object, request = c("post","del"), duration = 30)
                   {
                      switch(EXPR = request,
                             "post" = {
                                if (!is.numeric(duration))
                                {
                                   stop("\"duration\" must be \"numeric\".")
                                }

                                response <- httr::POST(url = sprintf("https://data.qivivo.com/api/v2/devices/thermostats/%s/arrival",
                                                                     object@UUID),
                                                       body = list(duration = duration),
                                                       httr::accept_json(),
                                                       httr::add_headers(Authorization = sprintf("%s %s",                                                                                      object@token$credentials$token_type,
                                                                                                 object@token$credentials$token_type,
                                                                                                 object@token$credentials$access_token)),
                                                       config = list(token = object@token))
                             },
                             "del" = {
                                response <- httr::DELETE(url = sprintf("https://data.qivivo.com/api/v2/devices/thermostats/%s/arrival",
                                                                       object@UUID),
                                                         httr::accept_json(),
                                                         httr::add_headers(Authorization = sprintf("%s %s",                                                                                      object@token$credentials$token_type,
                                                                                                   object@token$credentials$token_type,
                                                                                                   object@token$credentials$access_token)),
                                                         config = list(token = object@token))
                             },
                             stop("\"request\" can only take \"post\" ou \"del\" values."))

                      if (httr::status_code(response) == 200)
                      {
                         message(httr::content(response)$message)
                      }
                      else
                      {
                         stop(object@badConnection)
                      }
                   })
