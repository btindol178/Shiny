# Inputs
library(shiny)
library(ggplot2)
library(dplyr)
babynames <- read.csv("babynames_f.csv")
babynames <-babynames[-c(1)]

ui <- fluidPage(
  titlePanel("What's in a Name?"),
  # Add select input named "sex" to choose between "M" and "F"
  
  selectInput('sex', 'Select Sex', choices = c("F", "M")),
  
  # CODE BELOW: Add slider input named 'year' to select years (1900 - 2010)
  sliderInput('year', 'Select Year', min = 1900, max = 2010, value = 1900),
 
   # Add plot output to display top 10 most popular names
  plotOutput('plot_top_10_names')
)

server <- function(input, output, session){
  # Render plot of top 10 most popular names
  output$plot_top_10_names <- renderPlot({
    # Get top 10 names by sex and year
    top_10_names <- babynames %>% 
      filter(sex == input$sex) %>% 
      # MODIFY CODE BELOW: Filter for the selected year
      filter(year == input$year) %>% 
      top_n(10, prop)
    
    # Plot top 10 names by sex and year
    ggplot(top_10_names, aes(x = name, y = prop)) +
      geom_col(fill = "#263e63")
  })
}

shinyApp(ui = ui, server = server)