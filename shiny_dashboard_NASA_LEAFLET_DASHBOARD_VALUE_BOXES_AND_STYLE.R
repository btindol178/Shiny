#Then use the color parameter such that if n_us is less than 10, the value box is blue, otherwise it is fuchsia. The following logic can be used to determine the color.

# nasa_fireball data
nasa_fireball <- read.csv("nasa_fireball.csv")
colnames(nasa_fireball)[1] <- "date"

library("shiny")
library("leaflet")

max_impact_e <- max(nasa_fireball$impact_e)
max_energy <- max(nasa_fireball$energy)
max_vel <- max(nasa_fireball$vel, na.rm = TRUE) # make a bot that gives max of velocity



server <- function(input, output) {
  output$plot <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%  
      addCircleMarkers(
        lng = nasa_fireball$lon,
        lat = nasa_fireball$lat, 
        radius = log(nasa_fireball$impact_e), 
        label = nasa_fireball$date, 
        weight = 2)
  })
}

body <- dashboardBody(
  fluidRow(
    valueBox(
      value = max_energy, 
      subtitle = "Maximum total radiated energy (Joules)", 
      icon = icon("lightbulb-o")
    ),
    valueBox(
      value = max_impact_e, 
      subtitle = "Maximum impact energy (kilotons of TNT)",
      icon = icon("star")
    ),
    valueBox(
      value = max_vel,
      subtitle = "Maximum pre-impact velocity", 
      icon = icon("fire")
    )
  ),
  fluidRow(
    leafletOutput("plot")
  )
)

ui <- dashboardPage(
  skin = "purple",
  header = dashboardHeader(),
  sidebar = dashboardSidebar(),
  body = dahsboardBody()
)

shinyApp(ui, server)