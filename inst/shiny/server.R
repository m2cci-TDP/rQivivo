shiny::shinyServer(function(input, output, session)
{
   # Initialisation
   reactiveObject <- shiny::reactiveValues(
       token = NULL,
       UUID = NULL
   )

   shiny::observeEvent(input$btnConnect, {
      withBusyIndicatorServer("btnConnect", {
         reactiveObject$token <- rQivivo::connect()
      })

      reactiveObject$UUID <- httr::content(getInfoDevice(reactiveObject$token))$devices[[1]]$uuid
      output$connectResponse <- shiny::renderText(expr = reactiveObject$UUID)
   })
})
