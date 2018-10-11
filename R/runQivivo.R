#' @title run Shiny app for Qivivo
#' @name runQivivo
#' @description The function uses \code{\link[shiny]{runApp}} in the default browser.
#' @export
runQivivo <- function()
{
   shiny::runApp(appDir = system.file("shiny",
                                      package = "rQivivo",
                                      mustWork = TRUE),
                 launch.browser = TRUE)
}
