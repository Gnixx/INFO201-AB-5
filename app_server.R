# app server
library(shiny)
library(plotly)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(readr)

source("school_info.R")

# Read in data ----------------------------------------------------------------
## Map data
closure <- read.csv("docs/Closure Status.csv") %>%
   mutate(Year = str_sub(Date, 7, 10)) %>%
   filter(Year >= "2021") %>%
   mutate(Date = as.Date(Date, "%d/%m")) %>%
   filter(Date == max(Date))
closure$Status_num <- str_replace_all(closure$Status, c(
  "Fully open" = "0",
  "Academic break" = "0",
  "Partially open" = "5",
  "Closed due to COVID-19" = "10"
))


## Timeline data
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


## Histogram data
# Extracting needed rows
closure_duration <- school_closures %>%
  select(X, X.1, UNESCO.global.dataset.on.the.duration.of.school.closures, X.2) %>%
  slice(-c(1:18)) %>%
  summarise(
    country_name = X,
    country_code = X.1,
    full_partial_duration_inweeks = UNESCO.global.dataset.on.the.duration.of.school.closures,
    full_closure_inweeks = X.2
  )
# blank theme for plot
blank_theme <- theme_bw() +
  theme(
    plot.background = element_blank(), # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank(), # remove boarder around plot
  )


# Start shinyServer -----------------------------------------------------------
server <- function(input, output) {
  ## Map ---------------------------
  date <- unique(closure$Date)
  world_map <- map_data("world") %>%
     rename(Country = region) %>%
     left_join(closure, by = "Country")
  map <- ggplot(world_map) +
     geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = Status),
        color = "white",
        size = .1
     ) +
     # coord_map() +
     #scale_fill_discrete("Purples") +
     scale_fill_manual(values = c("tan2", "tan4", "tan1", "tan3")) +
     labs(fill = "status") +
     ggtitle(paste("School Closure at", date))
  map

  ## Timeline ---------------------------
  output$Timeline <- renderPlotly({
    data <- df %>%
      filter(AgeGroup == input$age) %>%
      select(Date, OneDose, FullyVaccinated, WeeklyCasesPer100k)

    vars <- setdiff(names(data), "Date")
    plots <- lapply(vars, function(var) {
      plot_ly(data, x = ~Date, y = as.formula(paste0("~", var))) %>%
        add_lines(name = var) %>%
        layout(title = paste("COVID-19 Trends in", input$age))
    })
    subplot(plots, nrows = length(plots), shareX = TRUE, titleX = FALSE)
  })

  ## Histogram ---------------------------
  output$schoolClosure <- renderPlotly({
    data <- closure_duration %>%
      top_n(input$top, wt = full_closure_inweeks)

    closure_plot <- ggplot(data = data) +
      geom_col(aes(x = country_name, y = full_closure_inweeks, fill = "red")) +
      coord_flip() +
      xlab("Country") +
      ylab("Weeks") +
      ggtitle(paste("Top ", input$top, "Countries with Longest School Closure ")) +
      scale_fill_manual(values = c("orange4")) +
      blank_theme +
      theme(legend.position = "none")

    closure_plotly <- ggplotly(closure_plot)

    return(closure_plotly)
  })


  # ## pie ---------------------------
  output$pie <- renderPlotly({
    ## Piechart data
    country <- read.csv("covid-19-testing-policy.csv") %>%
      filter(testing_policy == "3") %>%
      group_by(Entity) %>%
      summarise(Day = n()) %>%
      sample_n(input$slider1) # input$countrychoice

    slider1 <- seq(0, 100, length.out = input$slider1 + 1)

    pieplot <- plot_ly(country,
      labels = ~Entity,
      values = ~Day, type = "pie"
    ) %>%
      layout(
        title = "Countries with most accessible testing policy, by day",
        xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
        yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
    return(pieplot)
  })
}
