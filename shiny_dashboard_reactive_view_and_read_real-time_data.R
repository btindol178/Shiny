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

# You could do this directly from the John hopkins github repository
#starwars_url <- "C:/Users/blake/OneDrive/Stryker Project/Learning Shiny/starwars.csv"
starwars_url2 <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_6225/datasets/starwars.csv"

server <- function(input, output, session) {
  reactive_starwars_data <- reactiveFileReader(
    intervalMillis = 1000,
    session = session,
    filePath = starwars_url2,
    readFunc = function(filePath) { 
      read.csv(url(filePath))
    }
  )
  
  output$table <- renderTable({
    reactive_starwars_data()
  })
}

body <- dashboardBody(
  tableOutput("table")
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)
shinyApp(ui, server)