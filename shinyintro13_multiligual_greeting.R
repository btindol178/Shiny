# Putting everything together
library(shiny)
library(ggplot2)
library(dplyr)
library(DT) # library to make interactive table
library(plotly)
install.packages("shinythemes")
library(shinythemes)

ui <- fluidPage(
  selectInput('greeting_type', 'Select greeting', c("Hello", "Bonjour")),
  textInput('name', 'Enter your name'),
  textOutput('greeting')
)

server <- function(input, output, session) {
  output$greeting <- renderText({
    paste(input$greeting_type, input$name, sep = ", ")
  })
}

shinyApp(ui = ui, server = server)