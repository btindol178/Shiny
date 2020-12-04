library(shiny)
library(ggplot2)
library(dplyr)
library(DT) # library to make interactive table
library(plotly)

top_trendy_names <- read.csv("top_trendy_names.csv")
colnames(top_trendy_names)[1] <- "name"

babynames <- read.csv("babynames_f.csv")
babynames <-babynames[-c(1)]

ui <- fluidPage(
  selectInput('name', 'Select Name', top_trendy_names$name), # use top trendy names pick unique names
  # CODE BELOW: Add a plotly output named 'plot_trendy_names'
  plotly::plotlyOutput('plot_trendy_names')
)
server <- function(input, output, session){
  # Function to plot trends in a name
  plot_trends <- function(){ 
    babynames %>% 
      filter(name == input$name) %>% 
      ggplot(aes(x = year, y = n)) +
      geom_col()
  }
  # CODE BELOW: Render a plotly output named 'plot_trendy_names'
  output$plot_trendy_names <- plotly::renderPlotly({
    plot_trends() # using the filtered dataset with name as input year as x and n as y
  })
}
shinyApp(ui = ui, server = server)