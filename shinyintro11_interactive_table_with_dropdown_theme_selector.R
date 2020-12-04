library(shiny)
library(ggplot2)
library(dplyr)
library(DT) # library to make interactive table
library(plotly)
install.packages("shinythemes")
library(shinythemes)

# get dataframe of top few names
top_trendy_names <- read.csv("top_trendy_names.csv")
colnames(top_trendy_names)[1] <- "name"

# whole dataframe of baby names
babynames <- read.csv("babynames_f.csv")
babynames <-babynames[-c(1)]


ui <- fluidPage(
  # CODE BELOW: Add a titlePanel with an appropriate title
  
  # REPLACE CODE BELOW: with theme = shinythemes::shinytheme("<your theme>")
  shinythemes::themeSelector(),
  sidebarLayout(
    sidebarPanel(
      selectInput('name', 'Select Name', top_trendy_names$name)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel('Plot', plotly::plotlyOutput('plot_trendy_names')),
        tabPanel('Table', DT::DTOutput('table_trendy_names'))
      )
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