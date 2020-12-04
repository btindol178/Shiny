library(shiny)
install.packages("gapminder")
library(gapminder) # load dataset
library(ggplot2)

# make it to dataframe from environment dataframe
gapminder <- data.frame(gapminder)

# Define UI for the application
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      # Add a title text input
      textInput("title", "Title", "GDP vs life exp")
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  output$plot <- renderPlot({
    ggplot(gapminder, aes(gdpPercap, lifeExp)) +
      geom_point() +
      scale_x_log10() +
      # Use the input value as the plot's title
      ggtitle(input$title)
  })
}

# Run the application
shinyApp(ui = ui, server = server)