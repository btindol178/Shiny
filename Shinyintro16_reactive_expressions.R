library(shiny)
library(ggplot2)
library(dplyr)
library(DT) # library to make interactive table
library(plotly)
install.packages("shinythemes")
library(shinythemes)



ui <- fluidPage(
  titlePanel('BMI Calculator'), # title panel will say this
  sidebarLayout( # in side bar and side panel how two input things 
    sidebarPanel(
      numericInput('height', 'Enter your height in meters', 1.5, 1, 2), # low is 1.5 high 4 start at 2
      numericInput('weight', 'Enter your weight in kilograms', 60, 40, 120) # weight low 60 high 300 start 120
    ),
    mainPanel(
      textOutput("bmi"),
      textOutput("bmi_range")
    )
  )
)

server <- function(input, output, session) {
  
  # CODE BELOW: Add a reactive expression rval_bmi to calculate BMI
  rval_bmi <- reactive({             # make a reactive expression that is taking input 1 and 2 and doing calculation to be used later
    input$weight/(input$height^2)
  })
  
  # Take the reactive calculation rval_bmi() and use it in text output
  output$bmi <- renderText({  
    
    # MODIFY CODE BELOW: Replace right-hand-side with reactive expression
    bmi <- rval_bmi()
    paste("Your BMI is", round(bmi, 1))
  })
  output$bmi_range <- renderText({
    # MODIFY CODE BELOW: Replace right-hand-side with reactive expression
    bmi <- rval_bmi()
    bmi_status <- cut(bmi, 
                      breaks = c(0, 18.5, 24.9, 29.9, 40),
                      labels = c('underweight', 'healthy', 'overweight', 'obese')
    )
    paste("You are", bmi_status)
  })
}

shinyApp(ui = ui, server = server)