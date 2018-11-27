#' @title Refresh the OAuth connection
#' @name refresh
#' @description The function refresh the current authorization with the \code{refresh_token}.
#'
#' @usage refresh(object)
#'
#' @param object an rQivivo S4 object.
#'
#' @exportMethod refresh
#' @rdname refresh
#' @author Theo DEVAUCOUP \email{theo.devaucoup@@pm.me}
methods::setGeneric(name = "refresh",
                    def = function(object)
                    {
                       standardGeneric("refresh")
                    })

#' @title GET some information about the thermostat
#' @name getThermostat
#' @description The function provides get resquest about the thermostat.
#'
#' @usage getThermostat(object, type)
#'
#' @param object an rQivivo S4 object.
#' @param type character: type of \code{\link[httr]{GET}} request:
#' \describe{
#'    \item{"info":}{gives some information about the device;}
#'    \item{"temperature":}{gives the temperature;}
#'    \item{"humidity":}{gives the humidity;}
#'    \item{"presence":}{gives the last presence.}
#' }
#'
#' @return The function returns the content of the get request.
#' @exportMethod getThermostat
#' @rdname getThermostat
#' @author Theo DEVAUCOUP \email{theo.devaucoup@@pm.me}
methods::setGeneric(name = "getThermostat",
                    def = function(object, type)
                    {
                       standardGeneric("getThermostat")
                    })

#' @title ACTIVE or DELETE the absence
#' @name absence
#' @description The function changes the thermostat into the frost temperature or cancels the absence mode.
#'
#' @usage absence(object, request, body)
#'
#' @param object an rQivivo S4 object.
#' @param request character:
#' \describe{
#'    \item{"post":}{sets the thermostat into absence mode (i.e. the frost temperature);}
#'    \item{"del":}{removes the absence mode.}
#' }
#' @param body list: only if \code{request = "post"}:
#' \describe{
#'    \item{start_date POSIXt:}{the starting date of the absence;}
#'    \item{end_date POSIXt:}{the ending date of the absence.}
#' }
#'
#' @exportMethod absence
#' @rdname absence
#' @author Theo DEVAUCOUP \email{theo.devaucoup@@pm.me}
methods::setGeneric(name = "absence",
                    def = function(object, request, body)
                    {
                       standardGeneric("absence")
                    })

#' @title ACTIVE or DELETE the arrival
#' @name arrival
#' @description The function starts or stops heating the house earlier than the programmation was anticipating.
#'
#' @usage arrival(object, request, duration)
#'
#' @param object an rQivivo S4 object.
#' @param request character:
#' \describe{
#'    \item{"post":}{sets the thermostat into arrival mode (i.e. to start heating);}
#'    \item{"del":}{removes the arrival mode.}
#' }
#' @param duration numeric: duration before the arrival, to start heating (in minutes).
#'
#' @exportMethod arrival
#' @rdname arrival
#' @author Theo DEVAUCOUP \email{theo.devaucoup@@pm.me}
methods::setGeneric(name = "arrival",
                    def = function(object, request, duration)
                    {
                       standardGeneric("arrival")
                    })
