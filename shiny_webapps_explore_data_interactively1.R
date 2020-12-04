library(shiny)
install.packages("gapminder")
library(gapminder) # load dataset
library(ggplot2)
# Load the colourpicker package
install.packages("colourpicker")
library(colourpicker)
library(plotly)

final_df <- read.csv("finaldataframe.csv")

# make it to dataframe from environment dataframe
df <- data.frame(final_df)

ui <- fluidPage(
  h1("Covid"),
  # Add a placeholder for a table output
  tableOutput("table")
)

server <- function(input, output) {
  # Call the appropriate render function
  output$table <- renderTable({
    # Show the gapminder object in the table
    df
  })
}

shinyApp(ui, server)