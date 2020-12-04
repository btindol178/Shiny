library(shiny)
library(ggplot2)
library(dplyr)
library(DT) # library to make interactive table
library(plotly)
install.packages("shinythemes")
library(shinythemes)

#get gapminderdataset
gapminder <- read.csv("gapminder.csv")

# Load user interface using fluidPage
ui <- fluidPage(
  # make title panel
  titlePanel("Life Expectation vs. GDP per Capita"),
  
  sidebarLayout(
    sidebarPanel(
  #Select continent through dropdown
  selectInput('continent', 'Select Continent',unique(gapminder$continent)),
  
  #Make slider for year
  sliderInput('year', 'Select Year',1952,2007,1992, step = 5) # step =5 because gapminder dataset goes by every 5 years (the other numbers is min max and default year
    ),
  
  mainPanel(
    tabsetPanel(
      # Plot output
      tabPanel("Plot",plotOutput('plot')),
      tabPanel("Table",DT::DTOutput('table'))
   )
  )
 )
)
  # Make the server
  server <- function(input,output,session){ 
  
  #Make a plot output to go with our UI
  output$plot <- renderPlot({  # make the first output
   data <- gapminder %>%           # make gapminder filterable dataframe called data
     filter(year == input$year) %>%    # let input be filtered by year
     filter(continent == input$continent) # let input befiltered by continent
   print(data)
   ggplot(data,aes(x=gdpPercap, y = lifeExp)) +   # plot out with ggplot2
     geom_point()
})
  
  #make the table with the full gapminder dataset
  output$table <- DT::renderDT({
    gapminder %>% 
      filter(year == input$year) %>% # let the reactive table be filtered by these 2
      filter(continent == input$continent)
  })
  
}

shinyApp(ui=ui, server=server)