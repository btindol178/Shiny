#Then use the color parameter such that if n_us is less than 10, the value box is blue, otherwise it is fuchsia. The following logic can be used to determine the color.

# nasa_fireball data
nasa_fireball <- read.csv("nasa_fireball.csv")
colnames(nasa_fireball)[1] <- "date"

library("shiny")

max_impact_e <- max(nasa_fireball$impact_e)
max_energy <- max(nasa_fireball$energy)
max_vel <- max(nasa_fireball$vel, na.rm = TRUE) # make a bot that gives max of velocity

n_us <- sum(
  ifelse(
    nasa_fireball$lat < 64.9 & nasa_fireball$lat > 19.5
    & nasa_fireball$lon < -68.0 & nasa_fireball$lon > -161.8,
    1, 0),
  na.rm = TRUE)

server <- function(input, output) {
  output$us_box <- renderValueBox({
    valueBox(
      value = n_us,
      subtitle = "Number of Fireballs in the US",
      icon = icon("globe"),
      color = if (n_us < 10) {
        "blue"
      } else {
        "fuchsia"
      }
    )
  })
}

body <- dashboardBody(
  fluidRow(
    valueBoxOutput("us_box")
  )
)
ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)
shinyApp(ui, server)