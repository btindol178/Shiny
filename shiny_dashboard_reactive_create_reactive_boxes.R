library(shinydashboard)
library(shiny)
library(dplyr)

#starwars <- data.frame(starwars)# comes right from dplyr
# Create an empty header
header <- dashboardHeader()
# Create an empty sidebar
sidebar <- dashboardSidebar()
# Create an empty body
body <- dashboardBody()

sidebar <- dashboardSidebar(
  actionButton("click", "Update click box")
) 

server <- function(input, output) {
  output$click_box <- renderValueBox({
    valueBox(
      input$click, 
      "Click Box"
    )
  })
}

body <- dashboardBody(
  valueBoxOutput("click_box")
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)
shinyApp(ui, server)