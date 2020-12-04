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
  sidebarPanel(
    selectInput("state", "Choose a U.S. state:", choices = unique(usa_ufo_sightings$state)),
    dateRangeInput("dates", "Choose a date range:",
                   start = "1920-01-01",
                   end = "1950-01-01"
    )
  ),
  # MODIFY CODE BELOW: Create a tab layout for the dashboard
  mainPanel(
    tabsetPanel(
      tabPanel("Number sighted", plotOutput("shapes")),
      tabPanel("Duration table", tableOutput("duration_table"))
    )
  )
)

server <- function(input, output) {
  output$shapes <- renderPlot({
    usa_ufo_sightings %>%
      filter(
        state == input$state,
        date_sighted >= input$dates[1],
        date_sighted <= input$dates[2]
      ) %>%
      ggplot(aes(shape)) +
      geom_bar() +
      labs(
        x = "Shape",
        y = "# Sighted"
      )
  })
  
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
        avg_duration_min = mean(duration_sec) / 60,
        median_duration_min = median(duration_sec) / 60,
        min_duration_min = min(duration_sec) / 60,
        max_duration_min = max(duration_sec) / 60
      )
  })
}

shinyApp(ui, server)