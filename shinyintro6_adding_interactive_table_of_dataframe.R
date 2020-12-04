# Inputs
library(shiny)
library(ggplot2)
library(dplyr)
library(DT) # library to make interactive table

babynames <- read.csv("babynames_f.csv")
babynames <-babynames[-c(1)]

ui <- fluidPage(
  titlePanel("What's in a Name?"),
  
  # Add select input named "sex" to choose between "M" and "F"
  selectInput('sex', 'Select Sex', choices = c("M", "F")),
  
  # Add slider input named "year" to select year between 1900 and 2010
  sliderInput('year', 'Select Year', min = 1900, max = 2010, value = 1900),
  
  # Add plot output to display top 10 most popular names
  DT::DTOutput('table_top_10_names')
)
server <- function(input, output, session){
  top_10_names <- function(){
    babynames %>% 
      filter(sex == input$sex) %>% 
      filter(year == input$year) %>% 
      top_n(10, prop)
  }
  # MODIFY CODE BELOW: Render a DT output named "table_top_10_names"
  output$table_top_10_names <- DT::renderDT({
    top_10_names()
  })
}
shinyApp(ui = ui, server = server)