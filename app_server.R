# app server
library(shiny)
library(plotly)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(readr)

## Read in data
df <- read.csv("docs/Vaccination.csv") %>%
  mutate(Year = str_sub(Date.Administered, 7, 10)) %>%
  mutate(Month = str_sub(Date.Administered, 1, 2)) %>%
  mutate(Date = str_sub(Date.Administered, 1, 5)) %>%
  filter(Year >= "2021") %>%
  rename(
    AgeGroup = AgeGroupVacc,
    WeeklyCasesPer100k = X7.day_avg_group_cases_per_100k,
    OneDose = Administered_Dose1_pct_agegroup,
    FullyVaccinated = Series_Complete_Pop_pct_agegroup
  )
df$Date.Administered <- NULL
df$Date <- as.Date(df$Date, format = "%m/%d")

testingpolicies <- read_csv("docs/covid-19-testing-policy.csv")



## Start shinyServer
server <- function(input, output) {
  ## Timeline
  output$Timeline <- renderPlotly({
    data <- df %>%
      filter(AgeGroup == input$age) %>%
      select(Date, OneDose, FullyVaccinated) %>%
      gather(key = Vacc, value = percentage, -Date)


    p <- ggplot(data, aes(
      x = Date, y = percentage / 100,
      color = Vacc
    )) +
      geom_line() +
      scale_y_continuous(labels = scales::percent) +
      labs(
        title = paste("COVID-19 Vaccination Trends in", input$age),
        x = "Date", y = "Percent of population"
      ) +
      scale_color_manual(values = c("orange4", "orange"))

    fig <- ggplotly(p)
    return(fig)
  })

  ## pie
  output$pie <- renderPlotly({
    country <- testingpolicies %>%
      filter(testing_policy == "3") %>%
      group_by(Entity) %>%
      summarise(Day = n()) %>%
      sample_n(15) # input$countrychoice)

    pieplot <- plot_ly(country,
      labels = ~Entity,
      values = ~Day, type = "pie"
    ) %>%
      layout(
        title = "Countries testing policy levels",
        xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
        yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
    pieplot
    # return(pieplot)
  })
}
