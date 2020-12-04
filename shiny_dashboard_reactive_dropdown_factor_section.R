library(shinydashboard)
library(shiny)
library(dplyr)

starwars <- data.frame(starwars)# comes right from dplyr

# Create an empty header
header <- dashboardHeader()
# Create an empty sidebar
sidebar <- dashboardSidebar()
# Create an empty body
body <- dashboardBody()


sidebar <- dashboardSidebar(
  # Create a select list
  selectInput(inputId = "name", 
              label = "Name",
              choices = starwars$name
  )
)
body <- dashboardBody(
  textOutput("name")
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)

server <- function(input, output) {
  output$name <- renderText({
    input$name
  })
}

shinyApp(ui, server)