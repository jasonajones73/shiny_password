require(shiny)
require(shinythemes)


navbarPage(
  title = "Password Testing", collapsible = TRUE, fluid = TRUE,
  theme = shinytheme(theme = "yeti"),
  
  tabPanel(
    title = "Simulation", icon = icon(name = "calculator", class = "fa-2x", lib = "font-awesome"),
    sidebarLayout(
      sidebarPanel(actionLink("modal", label = "Click Here to Create An Account")),
      mainPanel(dataTableOutput("test"))
    )
  )
  
) # navbar-page

