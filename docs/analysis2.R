# https://data.cdc.gov/Vaccinations/COVID-19-Vaccination-and-Case-Trends-by-Age-Group-/gxj9-t96f
library(tidyverse)
library(stringr)
library(dplyr)
library(ggplot2)
library(wesanderson)

vacc <- read.csv("Vaccination.csv") %>%
   mutate(year = str_sub(Date.Administered, 7, 10)) %>%
   filter(year >= "2021") %>%
   group_by(AgeGroupVacc) %>%
   mutate(date = str_sub(Date.Administered, 1, 5)) %>%
   rename(age = AgeGroupVacc,
          cases = X7.day_avg_group_cases_per_100k,
          dose1 = Administered_Dose1_pct_agegroup,
          complete = Series_Complete_Pop_pct_agegroup) %>%
   drop_na()

vacc$date <- as.Date(vacc$date, format = "%m/%d")

vacc_12_17 <- vacc %>%
   filter(age %in% c("12 - 15 Years", "16 - 17 Years")) %>%
   group_by(date) %>%
   summarise(dose1_12_17 = sum(dose1),
             complete_12_17 = sum(complete))

vacc_12_24 <- vacc %>%
   filter(age == "18 - 24 Years") %>%
   group_by(date) %>%
   select(date, dose1, complete) %>%
   rename(dose1_18_24 = dose1,
          complete_18_24 = complete) %>%
   left_join(vacc_12_17, by="date") %>%
   gather(key = vacc, value = percentage, -date)

vacc_trend_chart <- ggplot(vacc_12_24, aes(x = date, y = percentage / 100, 
                                           group = vacc, color = vacc)) + 
   geom_line() + 
   scale_y_continuous(labels = scales::percent) + 
   labs(title = "COVID-19 Vaccination Trends by Age Group, United States", 
        x = "Date", y = "Percent of population") + 
   scale_color_manual(values = c("orange4", "steelblue4", "orange", "steelblue1"))
vacc_trend_chart


# Aggregate Table Script
# vaccination and cases 21 summer 

Colleges <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/colleges/colleges.csv")
Colleges$location <- paste(Colleges$county, Colleges$city)
College_cases <- Colleges %>%
   select(state, location, cases) %>%
   group_by(state) %>%
   summarise(state_sum = sum(cases))

date <- unique(Colleges$date)

highest_state <- College_cases %>%
   filter(state_sum == max(state_sum)) %>%
   pull(state)

College_cases_table <- knitr::kable(College_cases)
