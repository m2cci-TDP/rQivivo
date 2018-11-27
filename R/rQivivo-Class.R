methods::setOldClass("Token2.0")
methods::setOldClass("simpleError")
#' @title rQivivo S4 class
#' @description rQivivo class with OAuth2.0 using httr for API connection.
#' See \href{https://documenter.getpostman.com/view/1147709/qivivo-api/2MsDNL#d64f1f8b-f8e9-6470-50d5-980393886046}{Qivivo API}.
#' @name rQivivo-class
#'
#' @slot token Token2.0: return of \code{\link[httr]{oauth2.0_token}} function.
#' @slot UUID character: UUID of the thermostat.
#'
#' @rdname rQivivo-class
#' @exportClass rQivivo
#' @author Theo DEVAUCOUP \email{theo.devaucoup@@pm.me}
methods::setClass(Class = "rQivivo",
                  representation = methods::representation(token = "Token2.0",
                                                           UUID = "character",
                                                           badConnection = "simpleError")
)
