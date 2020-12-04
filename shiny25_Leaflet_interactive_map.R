library(ggplot2)
library(dplyr)
library(DT) # library to make interactive table
library(plotly)
install.packages("shinythemes")
library(shinythemes)
install.packages("shinyWidgets")
library(shinyWidgets)
library(reshape2)
library(leaflet)

mass_shootings <- read.csv("mass-shootings.csv")


server <- function(input, output, session) {
  rval_mass_shootings <- reactive({
    # MODIFY CODE BELOW: Filter mass_shootings on nb_fatalities and 
    # selected date_range.
    mass_shootings %>% 
      filter(
        date >= input$date_range[1],
        date <= input$date_range[2],
        fatalities >= input$nb_fatalities
      )
  })
  output$map <- leaflet::renderLeaflet({
    rval_mass_shootings() %>%
      leaflet() %>% 
      addTiles() %>%
      setView( -98.58, 39.82, zoom = 5) %>% 
      addTiles() %>% 
      addCircleMarkers(
        # CODE BELOW: Add parameters popup and radius and map them
        # to the summary and fatalities columns
        popup = ~ summary, radius = ~ fatalities,
        fillColor = 'red', color = 'red', weight = 1
      )
  })
}
ui <- bootstrapPage(
  theme = shinythemes::shinytheme('simplex'),
  leaflet::leafletOutput('map', height = '100%', width = '100%'),
  absolutePanel(top = 10, right = 10, id = 'controls',
                sliderInput('nb_fatalities', 'Minimum Fatalities', 1, 40, 10),
                dateRangeInput('date_range', 'Select Date', "2010-01-01", "2019-12-01")
  ),
  tags$style(type = "text/css", "
    html, body {width:100%;height:100%}     
    #controls{background-color:white;padding:20px;}
  ")
)

shinyApp(ui, server)