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
  # MODIFY CODE BLOCK BELOW: Wrap in a sidebarLayout
  sidebarLayout(
    # MODIFY CODE BELOW: Wrap in a sidebarPanel
    sidebarPanel(
      selectInput('name', 'Select Name', top_trendy_names$name)
    ),
    # MODIFY CODE BELOW: Wrap in a mainPanel
    mainPanel(
      plotly::plotlyOutput('plot_trendy_names'),
      DT::DTOutput('table_trendy_names')
    )
  )
)
server <- function(input, output, session){
  # Function to plot trends in a name
  plot_trends <- function(){
    babynames %>% 
      filter(name == input$name) %>% 
      ggplot(aes(x = year, y = n)) +
      geom_col()
  }
  output$plot_trendy_names <- plotly::renderPlotly({
    plot_trends()
  })
  
  output$table_trendy_names <- DT::renderDT({
    babynames %>% 
      filter(name == input$name)
  })
}
shinyApp(ui = ui, server = server)