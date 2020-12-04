# nasa_fireball data
nasa_fireball <- read.csv("nasa_fireball.csv")
colnames(nasa_fireball)[1] <- "date"

library("shiny")

max_impact_e <- max(nasa_fireball$impact_e)
max_energy <- max(nasa_fireball$energy)
max_vel <- max(nasa_fireball$vel, na.rm = TRUE) # make a bot that gives max of velocity


body <- dashboardBody(
  fluidRow(
    # Add a value box for maximum energy
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
  )
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)

server <- function(input, output) {
  
}

shinyApp(ui, server)