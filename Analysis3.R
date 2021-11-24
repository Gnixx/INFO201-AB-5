library(tidyverse)
library(stringr)
library(dplyr)
library(plotly)
library(ggplot2)
library(maps)
library(usdata)
library(leaflet)


library(readr)
covid_19_testing_policy <- read_csv("covid-19-testing-policy.csv")
View(covid_19_testing_policy)


# FILTER COUNTRIES WITH HIGHEST TESTING POLICY FOR LONGEST TIME
country <- testingpolicies %>%
  filter(testing_policy == "3") %>%
  group_by(Entity) %>%
  summarise(Day = n()) %>%
  top_n(10)

# PIE CHART
daysofpolicies <- plot_ly(country, labels = ~Entity, 
                          values = ~Day, type = "pie")
daysofpolicies <- daysofpolicies %>%
  layout(
    title = "Countries testing policy levels",
    xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
    yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
  )
daysofpolicies


