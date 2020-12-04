# nasa_fireball data
nasa_fireball <- read.csv("nasa_fireball.csv")
colnames(nasa_fireball)[1] <- "date"

# Examine the types of variables present
sapply(nasa_fireball, class)

# Observe the number of observations in this data frame
nrow(nasa_fireball)

# Check for missing data
sapply(nasa_fireball, anyNA)

#################################################################################################################################################
#################################################################################################################################################
library("shiny")
max_vel <- max(nasa_fireball$vel, na.rm = TRUE) # make a bot that gives max of velocity

body <- dashboardBody(
  fluidRow(
    # Add a value box for maximum velocity
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