shiny::shinyServer(function(input, output, session)
{
   # Initialisation
   reactiveObject <- shiny::reactiveValues(
       rQivivoObject = NULL
   )

   shiny::observeEvent(input$btnConnect, {
      withBusyIndicatorServer("btnConnect", {
         reactiveObject$rQivivoObject <- rQivivo::rQivivo()
      })

      output$connectResponse <- shiny::renderText(expr = reactiveObject$rQivivoObject@UUID)
   })
})
