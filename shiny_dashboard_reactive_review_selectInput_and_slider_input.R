library(shinydashboard)
library(shiny)

# Create an empty header
header <- dashboardHeader()
# Create an empty sidebar
sidebar <- dashboardSidebar()
# Create an empty body
body <- dashboardBody()


sidebar <- dashboardSidebar(
  # Add a slider
  sliderInput(
    inputId = "height",
    label = "Height",
    min = 66,
    max = 264,
    value = 264)
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = dashboardBody()
)
shinyApp(ui, server) 