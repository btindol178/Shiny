# Set directory C:\Users\blake\OneDrive\Stryker Project\Learning Shiny

# always load library
library(shiny)

# call the ui or user interface
ui <- fluidPage("Hello, world!!!")

#call server
server <- function(input,output, session) {
  
}

# have to pass ui and server into app to run
shinyApp(ui = ui,server = server)
