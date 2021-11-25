
library(tidyverse)
library(stringr)
library(dplyr)
library(ggplot2)
library(wesanderson)
library(usmap)

# Loading data -------------------------------------------------------------------------

Colleges <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/colleges/colleges.csv")
source("./analysis2.R")

# Map -------------------------------------------------------------------------

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  )

# aapi_state <- incarceration_trends %>%
#   group_by(state) %>%
#   filter(year == max(year, na.rm = T)) %>%
#   filter(aapi_jail_pop == aapi_jail_pop) %>%
#   filter(total_pop == total_pop) %>%
#   mutate(total_pop / aapi_jail_pop) %>%
#   summarize(
#     pop = sum(aapi_jail_pop), total = max(total_pop),
#     mutate = sum(total_pop / aapi_jail_pop)
#   )

cases <- data.frame(College_cases)

cases_map <- plot_usmap(
  data = cases, values = "state_sum", color = "black"
) +
  blank_theme +
  scale_fill_gradientn(
    colours = c("white", "brown"),
    breaks = c(10, 100, 1000, 10000, 100000),
    trans = "log10", name = "Covid-19 Cases in United States' Colleges and Universities"
  ) +
  labs(title = "Covid-19 Cases in United States' Colleges and Universities") +
  theme(legend.position = "right")

