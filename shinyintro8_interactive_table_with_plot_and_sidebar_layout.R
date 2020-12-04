library(shiny)
library(ggplot2)
library(dplyr)
library(DT) # library to make interactive table
library(plotly)

# get dataframe of top few names
top_trendy_names <- read.csv("top_trendy_names.csv")
colnames(top_trendy_names)[1] <- "name"

# whole dataframe of baby names
babynames <- read.csv("babynames_f.csv")
babynames <-babynames[-c(1)]

ui <- fluidPage(
  # MODIFY CODE BELOW: Wrap in a sidebarLayout
  # MODIFY CODE BELOW: Wrap in a sidebarPanel
  selectInput('name', 'Select Name', top_trendy_names$name),
  # MODIFY CODE BELOW: Wrap in a mainPanel
  plotly::plotlyOutput('plot_trendy_names'),
  DT::DTOutput('table_trendy_names')
)
# DO NOT MODIFY
server <- function(input, output, session){
  # Function to plot trends in a name
  plot_trends <- function(){
    babynames %>% 
      filter(name == input$name) %>% 
      ggplot(aes(x = year, y = n)) +
      geom_col()
  }
  # this filters babynames based on top_trendy_name input
  output$plot_trendy_names <- plotly::renderPlotly({
    plot_trends()
  })
  
  # This filters for the full dataframe babynames and shows ouput
  output$table_trendy_names <- DT::renderDT({
    babynames %>% 
      filter(name == input$name) 
  })
}
shinyApp(ui = ui, server = server)