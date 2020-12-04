library(shiny)

# Define UI for the application
ui <- fluidPage(
  # Create a numeric input with ID "age" and label of
  # "How old are you?"
  numericInput(inputId = "age", label = "How old are you?", value = 20),
  
  # Create a text input with ID "name" and label of 
  # "What is your name?"
  textInput(inputId = "name", label = "What is your name?")
)

# Define the server logic
server <- function(input, output) {}

# Run the application
shinyApp(ui = ui, server = server)