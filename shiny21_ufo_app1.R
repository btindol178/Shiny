library(shiny)
library(ggplot2)
library(dplyr)
library(DT) # library to make interactive table
library(plotly)
install.packages("shinythemes")
library(shinythemes)

# load dataset
usa_ufo_sightings <- read.csv("usa_ufo_sightings.csv")

# make sure the data is in right data format
usa_ufo_sightings$date_sighted <- as.Date(usa_ufo_sightings$date_sighted)
usa_ufo_sightings$city <- as.character(usa_ufo_sightings$city)
usa_ufo_sightings$state<- as.character(usa_ufo_sightings$state)
usa_ufo_sightings$shape <- as.character(usa_ufo_sightings$shape)
usa_ufo_sightings$comments <- as.character(usa_ufo_sightings$comments)



ui <- fluidPage(
  titlePanel("UFO Sightings"),
  sidebarLayout(
    sidebarPanel(
      selectInput("state", "Choose a U.S. state:", choices = unique(usa_ufo_sightings$state)),
      dateRangeInput("dates", "Choose a date range:",
                     start = "1920-01-01",
                     end = "1950-01-01")
    ),
    mainPanel(
      # Add plot output named 'shapes'
      plotOutput("shapes"),
      # Add table output named 'duration_table'
      tableOutput("duration_table")
    )
  )
)


server <- function(input, output) {
  # CODE BELOW: Create a plot output name 'shapes', of sightings by shape,
  # For the selected inputs
  output$shapes <- renderPlot({
    usa_ufo_sightings %>%
      filter(state == input$state,
             date_sighted >= input$dates[1],
             date_sighted <= input$dates[2]) %>%
      ggplot(aes(shape)) +
      geom_bar() +
      labs(x = "Shape", y = "# Sighted")
  })
  # CODE BELOW: Create a table output named 'duration_table', by shape, 
  # of # sighted, plus mean, median, max, and min duration of sightings
  # for the selected inputs
  output$duration_table <- renderTable({
    usa_ufo_sightings %>%
      filter(
        state == input$state,
        date_sighted >= input$dates[1],
        date_sighted <= input$dates[2]
      ) %>%
      group_by(shape) %>%
      summarize(
        nb_sighted = n(),
        avg_duration = mean(duration_sec),
        median_duration = median(duration_sec),
        min_duration = min(duration_sec),
        max_duration = max(duration_sec)
      )
  })
}


shinyApp(ui, server)