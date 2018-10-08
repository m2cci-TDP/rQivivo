runQivivo <- function()
{
   appDir <- system.file("shiny",
                         package = "rQivivo",
                         mustWork = TRUE)

   shiny::runApp(appDir = appDir, launch.browser = TRUE)
}
