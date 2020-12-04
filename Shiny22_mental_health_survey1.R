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


ui <- fluidPage(
  # CODE BELOW: Add an appropriate title
  titlePanel("2014 Mental Health in Tech Survey"),
  sidebarPanel(
    # CODE BELOW: Add a checkboxGroupInput
    checkboxGroupInput(
      inputId = "mental_health_consequence",
      label = "Do you think that discussing a mental health issue with your employer would have negative consequences?",
      choices = c("Maybe", "Yes", "No"),
      selected = "Maybe"
    ),
    # CODE BELOW: Add a pickerInput
    pickerInput(
      inputId = "mental_vs_physical",
      label = "Do you feel that your employer takes mental health as seriously as physical health?",
      choices = c("Don't Know", "No", "Yes"),
      multiple = TRUE
    )
  ),
  mainPanel(
    # CODE BELOW: Display the output
    plotOutput("age")
  )
)

server <- function(input, output, session) {
  # CODE BELOW: Build a histogram of the age of respondents
  # Filtered by the two inputs
  output$age <- renderPlot({
    mental_health_survey %>%
      filter(
        mental_health_consequence %in% input$mental_health_consequence,
        mental_vs_physical %in% input$mental_vs_physical
      ) %>%
      ggplot(aes(Age)) +
      geom_histogram()
  })
}

shinyApp(ui, server)