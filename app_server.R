# app server
library(shiny)
library(plotly)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(readr)

source("school_info.R")

## Read in data
df <- read.csv("docs/COVID-19_Vaccination_and_Case_Trends.csv") %>%
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

country <- read_csv('./docs/covid-19-testing-policy.csv') %>%
  filter(testing_policy == "3") %>%
  group_by(Entity) %>%
  summarise(Day = n()) %>%
  sample_n(15) # input$countrychoice

#-----------------School Closure Data ------------------------------------------
# Extracting needed rows
closure_duration <- school_closures %>%
  select(X, X.1, UNESCO.global.dataset.on.the.duration.of.school.closures, X.2) %>%
  slice(-c(1:18)) %>%
  summarise(country_name = X,
            country_code = X.1,
            full_partial_duration_inweeks = UNESCO.global.dataset.on.the.duration.of.school.closures,
            full_closure_inweeks = X.2)

#blank theme for plot
blank_theme <- theme_bw() +
  theme(
    plot.background = element_blank(), # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank(), # remove boarder around plot
  )

## Start shinyServer
server <- function(input, output) {
  ## Timeline
  output$Timeline <- renderPlotly({
    data <- df %>%
      filter(AgeGroup == input$age) %>%
      select(Date, OneDose, FullyVaccinated) %>%
      gather(key = Vacc, value = percentage, -Date)

    p <- ggplot(data, aes(
      x = Date, y = percentage,
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
    output$schoolClosure <- renderPlotly({
      
      data <- closure_duration %>%
        top_n(input$top, wt = full_closure_inweeks)
      
      closure_plot <- ggplot(data = data) + 
        geom_col(aes(x = country_name, y = full_closure_inweeks, fill = "red")) +
        coord_flip() +
        xlab("Country") + 
        ylab("Weeks") +
        ggtitle(paste("Top ", input$top, "Countries with Longest School Closure "))  + 
        scale_fill_manual(values = c("orange4")) +
        blank_theme +
        theme(legend.position="none") 
      
      closure_plotly <- ggplotly(closure_plot)
      
      return(closure_plotly)
    })
  

  # pie
  output$pie <- renderPlotly({
    pieplot <- plot_ly(country,
      labels = ~Entity,
      values = ~Day, type = "pie"
    ) %>%
      layout(
        title = "Countries testing policy levels",
        xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
        yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
    # pieplot
    return(pieplot)
  })
}
