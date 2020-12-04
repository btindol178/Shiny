library(shiny)
library(ggplot2)
library(dplyr)
babynames <- read.csv("babynames_f.csv")
babynames <-babynames[-c(1)]

# User interface panel

# User interface
ui <- fluidPage(
  # make the title panel show baby name explorer
  titlePanel("Baby Name Explorer"),
  
  # put both the main and sidebar panel in side bar layout format
  sidebarLayout( 
    sidebarPanel(textInput('name', 'Enter Name', 'David')), # use name from server function as input title enter name and default to david
    mainPanel(plotOutput('trend')) # plot trend as declared in server function
  )
)
server <- function(input, output, session) {
  # server output make a plot called trend for output and plot babynames
  # using ggplot to plot year by proportion  and color is sex
  output$trend <- renderPlot({
    # CODE BELOW: Update to display a line plot of the input name
    ggplot(subset(babynames, name == input$name)) +
      geom_line(aes(x = year, y = prop, color = sex))
  })
}
shinyApp(ui = ui, server = server)