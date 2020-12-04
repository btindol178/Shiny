library(ggplot2)
library(dplyr)
library(DT) # library to make interactive table
library(plotly)
install.packages("shinythemes")
library(shinythemes)
install.packages("shinyWidgets")
library(shinyWidgets)
library(reshape2)


# Load data
recipes <- read.csv("recipes.csv")
recipes <- recipes[c(1:25)]

# Specify id.vars: the variables to keep but not split apart on
recipes2 <- melt(recipes, id.vars=c("cuisine", "recipe_id"))

recipes3 <- recipes2[!recipes2$value == "",]

recipes <- recipes3

ui <- fluidPage(
  titlePanel('Explore Cuisines'),
  sidebarLayout(
    sidebarPanel(
      selectInput('cuisine', 'Select Cuisine', unique(recipes$cuisine)),
      sliderInput('nb_ingredients', 'Select No. of Ingredients', 5, 100, 20),
    ),
    mainPanel(
      tabsetPanel(
        # CODE BELOW: Add `d3wordcloudOutput` named `wc_ingredients` in a `tabPanel`
        tabPanel('Word Cloud', d3wordcloud::d3wordcloudOutput('wc_ingredients', height = '400')),
        tabPanel('Plot', plotly::plotlyOutput('plot_top_ingredients')),
        tabPanel('Table', DT::DTOutput('dt_top_ingredients'))
      )
    )
  )
)
server <- function(input, output, session){
  # CODE BELOW: Render an interactive wordcloud of top distinctive ingredients 
  # and the number of recipes they get used in, using 
  # `d3wordcloud::renderD3wordcloud`, and assign it to an output named
  # `wc_ingredients`.
  output$wc_ingredients <- d3wordcloud::renderD3wordcloud({
    ingredients_df <- rval_top_ingredients()
    d3wordcloud(ingredients_df$ingredient, ingredients_df$nb_recipes, tooltip = TRUE)
  })
  rval_top_ingredients <- reactive({
    recipes_enriched %>% 
      filter(cuisine == input$cuisine) %>% 
      arrange(desc(tf_idf)) %>% 
      head(input$nb_ingredients) %>% 
      mutate(ingredient = forcats::fct_reorder(ingredient, tf_idf))
  })
  output$plot_top_ingredients <- plotly::renderPlotly({
    rval_top_ingredients() %>%
      ggplot(aes(x = ingredient, y = tf_idf)) +
      geom_col() +
      coord_flip()
  })
  output$dt_top_ingredients <- DT::renderDT({
    recipes %>% 
      filter(cuisine == input$cuisine) %>% 
      count(ingredient, name = 'nb_recipes') %>% 
      arrange(desc(nb_recipes)) %>% 
      head(input$nb_ingredients)
  })
}
shinyApp(ui = ui, server= server)