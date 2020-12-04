library(shiny)
install.packages("gapminder")
library(gapminder) # load dataset
library(ggplot2)
# Load the colourpicker package
install.packages("colourpicker")
library(colourpicker)
library(plotly)

# make it to dataframe from environment dataframe
gapminder <- data.frame(gapminder)

ui <- fluidPage(
  h1("Gapminder"),
  # Add a slider for life expectancy filter
  sliderInput(inputId = "life", label = "Life expectancy",
              min = 0, max = 120,
              value = c(30, 50)),
  tableOutput("table")
)

server <- function(input, output) {
  output$table <- renderTable({
    data <- gapminder
    data <- subset(
      data,
      # Use the life expectancy input to filter the data
      lifeExp >= input$life[1] & lifeExp <= input$life[2]
    )
    data
  })
}

shinyApp(ui, server)