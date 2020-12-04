library(shiny)
library(ggplot2)
library(dplyr)
library(DT) # library to make interactive table
library(plotly)
install.packages("shinythemes")
library(shinythemes)
install.packages("shinyWidgets")
library(shinyWidgets)

# Load data
mental_health_survey <- read.csv("mental_health_survey_edited.csv")

# Add a custom error message that will display by default letting users know they should select an input for mental versus physical health.
#Validate that a user made a selection
#Recall from the video that though it is often good practice to select a default value for your selector inputs, if one should be excluded, you can throw a custom error message to your users that clues them in on what they need to do for the app to run successfully.
#We saw in the last exercise that, without a default value for the pickerInput(), the plot is simply blank. Instead of a blank plot, in this exercise you'll show users a custom error message telling them to make the correct selection needed to get the app working.

ui <- fluidPage(
  titlePanel("2014 Mental Health in Tech Survey"),
  sidebarPanel(
    sliderTextInput(
      inputId = "work_interfere",
      label = "If you have a mental health condition, do you feel that it interferes with your work?", 
      grid = TRUE,
      force_edges = TRUE,
      choices = c("Never", "Rarely", "Sometimes", "Often")
    ),
    checkboxGroupInput(
      inputId = "mental_health_consequence",
      label = "Do you think that discussing a mental health issue with your employer would have negative consequences?", 
      choices = c("Maybe", "Yes", "No"),
      selected = "Maybe"
    ),
    pickerInput(
      inputId = "mental_vs_physical",
      label = "Do you feel that your employer takes mental health as seriously as physical health?", 
      choices = c("Don't Know", "No", "Yes"),
      multiple = TRUE
    )
  ),
  mainPanel(
    plotOutput("age")  
  )
)

server <- function(input, output, session) {
  output$age <- renderPlot({
    # MODIFY CODE BELOW: Add validation that user selected a 3rd input
    validate(
      need(
        input$mental_vs_physical != "", 
        "Make a selection for mental vs. physical health."
      )
    )
    
    mental_health_survey %>%
      filter(
        work_interfere == input$work_interfere,
        mental_health_consequence %in% input$mental_health_consequence,
        mental_vs_physical %in% input$mental_vs_physical
      ) %>%
      ggplot(aes(Age)) +
      geom_histogram()
  })
}


shinyApp(ui, server)