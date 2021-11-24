library(tidyverse)
library(stringr)
library(dplyr)
library(plotly)
library(ggplot2)
library(maps)
library(usdata)
library(leaflet)


<<<<<<< HEAD
library(readr)
covid_19_testing_policy <- read_csv("covid-19-testing-policy.csv")
View(covid_19_testing_policy)
=======
testingpolicies <- read.csv(file = "covid-19-testing-policy.csv", stringsAsFactors = FALSE)

#country <- testingpolicies %>%
#  filter(Entity == "China")

#country %>% 
#  group_by(testing_policy) %>%
# summarise(Day = n())

#View(country)

#daysofpolicies <- ggplot(country, aes(x ="", y = testing_policy, fill = Day)) +
#  geom_col() +
#  coord_polar(theta = "y")

#ggplotly(daysofpolicies)
>>>>>>> 28b82f736f0e22abb9c43863ecd16f1321916ce7

# FILTER COUNTRIES WITH HIGHEST TESTING POLICY FOR LONGEST TIME
country <- testingpolicies %>%
  filter(testing_policy == "3") %>%
  group_by(Entity) %>%
<<<<<<< HEAD
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
=======
  summarise(Day = n())
#sort by day, increasing


#daysofpolicies <- ggplot(country) +
#  geom_polygon(
#   mapping = aes(x = long, y = lat, group = group, fill = testing_policy),
#   color = "white",
#    size = .1) +
#  coord_map() +
#  labs(fill = "testing_policy") +
#  ggtitle("Countries testing policy levels") +
#  theme()

#daysofpolicies  


daysofpolicies <- ggplot(country, aes(x = Entity, y = Day)) +
  geom_point() +
  ggtitle("Countries testing policy levels")


ggplotly(daysofpolicies)
>>>>>>> 28b82f736f0e22abb9c43863ecd16f1321916ce7

