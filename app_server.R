#app server
library(shiny)
library(plotly)
library(dplyr)
library(tidyverse)
library(ggplot2)

library(readr)
testingpolicies <- read_csv("covid-19-testing-policy.csv")

server <- function(input, output) {
  
  output$pie <- renderPlotly({
    
    country <- testingpolicies %>%
      filter(testing_policy == "3") %>%
      group_by(Entity) %>%
      summarise(Day = n()) %>%
      sample_n(15)#input$countrychoice)
    
    pieplot <- plot_ly(country, labels = ~Entity, 
                       values = ~Day, type = "pie") %>%
      layout(
        title = "Countries testing policy levels",
        xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
        yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
    
    pieplot
    #return(pieplot)
  })
}