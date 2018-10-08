shinydashboard::dashboardPage(
   header <- shinydashboard::dashboardHeader(
      title = "QIVIVO",
      shiny::tags$li(class = "dropdown",
                     shiny::actionButton(inputId = "btnConnect",
                                         class = "BtnConnect",
                                         label = "Connection"))
   ),
   sidebar <- shinydashboard::dashboardSidebar(
      shinydashboard::sidebarMenu(id = "menuPrincipal",
                                  shinydashboard::menuItem("Test"))
   ),
   body <- shinydashboard::dashboardBody(
      shiny::tags$div(
         tags$h1("Connection"),
         tags$p(shiny::textOutput(outputId = "connectResponse"))
      )
   )
)
