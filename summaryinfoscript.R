# Load the tidyverse package
library(tidyverse)
library(dplyr)
library(ggplot2)

# Load the *enrollment_trends* data into a variable. `enrollment_trends` 
enrollment_trends <- read.csv("enrollment.csv")
covid_vaccine_and_case_trends <- read.csv("COVID-19_Vaccination_and_Case_Trends_by_Age_Group.csv")
covid_testing_policy <- read.csv("covid-19-testing-policy.csv")

#What was the total school enrollment in 2020?           
total_enrollment_in_2020 <- enrollment_trends %>% 
  group_by(year_enrollment) %>% 
  filter(year_enrollment == 2020) %>%
  summarise(enrollment_num = sum(enrollment,na.rm = TRUE)) %>% 
  select(enrollment_num)
total_enrollment_in_2020

#Which year from 2015 to 2020 had the highest total enrollment of students? <- enrollment.csv
highest_total_enrollment_year_2015to2020 <- enrollment_trends %>% 
  group_by(year_enrollment) %>% 
  filter(year_enrollment >= 2015) %>%
  summarise(enrollment_num = sum(enrollment,na.rm = TRUE)) %>% 
  filter(enrollment_num == max(enrollment_num)) %>% 
  pull(year_enrollment)
  highest_total_enrollment_year_2015to2020

  
#Which country had the highest school enrollment in 2019? 
highest_enrollment_country_in_2019 <- enrollment_trends %>% 
  group_by(countrycode) %>% 
  filter(year_enrollment == 2019) %>%
  summarise(enrollment_num = enrollment,na.rm = TRUE) %>% 
  filter(enrollment_num == max(enrollment_num)) %>% 
  pull(countrycode)
highest_enrollment_country_in_2019


#Which date has the highest 7 day average of daily cases reported for children ages 12-15?
highest_7_day_avg_cases_per_100k <- covid_vaccine_and_case_trends %>% 
  group_by(Date.Administered) %>% 
  filter(AgeGroupVacc == 	"12 - 15 Years") %>%
  summarise(seven_day_avg_num = X7.day_avg_group_cases_per_100k,na.rm = TRUE) %>% 
  filter(seven_day_avg_num == max(seven_day_avg_num)) %>% 
  select(Date.Administered)
highest_7_day_avg_cases_per_100k

##What was Austria's testing policy on 4/25/20?
austria_testing_policy <- covid_testing_policy %>% 
  group_by(Day) %>% 
  filter(Day == "4/25/20") %>% 
  filter(Entity == "Austria") %>% 
  pull(testing_policy)
austria_testing_policy




