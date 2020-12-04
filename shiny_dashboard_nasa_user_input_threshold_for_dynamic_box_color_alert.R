#Then use the color parameter such that if n_us is less than 10, the value box is blue, otherwise it is fuchsia. The following logic can be used to determine the color.

# nasa_fireball data
nasa_fireball <- read.csv("nasa_fireball.csv")
colnames(nasa_fireball)[1] <- "date"

library("shiny")

max_impact_e <- max(nasa_fireball$impact_e)
max_energy <- max(nasa_fireball$energy)
max_vel <- max(nasa_fireball$vel, na.rm = TRUE) # make a bot that gives max of velocity




sidebar <- dashboardSidebar(
  sliderInput(
    inputId = "threshold",
    label = "Color Threshold",
    min = 0,
    max = 100,
    value = 10)
)

server <- function(input, output) {
  output$us_box <- renderValueBox({
    valueBox(
      value = n_us,
      subtitle = "Number of Fireballs in the US",
      icon = icon("globe"),
      color = if (n_us < input$threshold) {
        "blue"
      } else {
        "fuchsia"
      }
    )
  })
}


ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)
shinyApp(ui, server)