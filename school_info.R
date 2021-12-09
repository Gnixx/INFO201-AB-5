library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)

# cleaning data - extracting needed rows
school_closures <- read.csv("https://en.unesco.org/sites/default/files/duration_school_closures.csv")

# cleaning data - extracting needed rows
closure_duration <- school_closures %>%
  select(X, X.1, UNESCO.global.dataset.on.the.duration.of.school.closures, X.2) %>%
  slice(-c(1:18)) %>%
  summarise(country_name = X,
            country_code = X.1,
            full_partial_duration_inweeks = UNESCO.global.dataset.on.the.duration.of.school.closures,
            full_closure_inweeks = X.2)

closure_duration_top <- closure_duration %>%
  top_n(20, wt = full_closure_inweeks)

#blank theme
blank_theme <- theme_bw() +
  theme(
    plot.background = element_blank(), # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank(), # remove boarder around plot
  )

#  Making the plot #1
closure_duration_plot <- ggplot(data = closure_duration_top) + 
  geom_col(aes(x = country_name, y = full_closure_inweeks, fill = "red")) +
  coord_flip() +
  xlab("Country") + 
  ylab("Weeks") +
  ggtitle("Top 20 Countries with Longest School Closure ")  + 
  scale_fill_manual(values = c("orange4")) +
  blank_theme +
  theme(legend.position="none") 

#Using Plotly
closure_duration_plotly <- ggplotly(closure_duration_plot, tooltip = c("text"))

#------------------------------ Plot #2 ----------------------------------------
group_by_duration <- closure_duration %>%
#  drop_na(full_partial_duration_inweeks) %>%
  select(full_partial_duration_inweeks, country_name) %>%
  group_by(full_partial_duration_inweeks) %>%
  summarise(country_count = n())

partial_closure_top <- group_by_duration %>%
  top_n(-20, wt = full_partial_duration_inweeks)

#  Making the plot #2
partial_duration_plot <- ggplot(data = partial_closure_top) + 
  geom_col(aes(x = full_partial_duration_inweeks, y = country_count, fill = "red")) +
  coord_flip() +
  xlab("No.Weeks") + 
  ylab("Country Count") +
  ggtitle("Partial Closure ")  + 
  scale_fill_manual(values = c("orange4")) +
  blank_theme +
  theme(legend.position="none") 

#Using Plotly
partial_duration_plotly <- ggplotly(partial_duration_plot, tooltip = c("text"))
