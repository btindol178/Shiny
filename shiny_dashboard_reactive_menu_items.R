library(shinydashboard)
library(shiny)
library(dplyr)


task_data = data.frame(text= c("find 20 hidden mickeys on the Tower of Terror","Find a baint brush","Blake island time"),
                      value = c(60,100,20))
#starwars <- data.frame(starwars)# comes right from dplyr
# Create an empty header
header <- dashboardHeader()
# Create an empty sidebar
sidebar <- dashboardSidebar()
# Create an empty body
body <- dashboardBody()

server <- function(input, output) {
  output$task_menu <- renderMenu({
    tasks <- apply(task_data, 1, function(row) {
      taskItem(text = row[["text"]],
               value = row[["value"]])
    })
    
    dropdownMenu(type = "tasks", .list = tasks)
  })
}

header <- dashboardHeader(dropdownMenuOutput("task_menu"))

ui <- dashboardPage(header = header,
                    sidebar = dashboardSidebar(),
                    body = dashboardBody()
)
shinyApp(ui, server)