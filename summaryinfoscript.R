# Load the tidyverse package
library(tidyverse)
library(dplyr)
library(ggplot2)

# Load the *enrollment_trends* data into a variable. `enrollment_trends` 
enrollment_trends <- read.csv("school-survey/01_data/011_rawdata/enrollment.csv")

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
  summarise(enrollment_num = sum(enrollment,na.rm = TRUE))
  filter(enrollment_num == max(enrollment)) %>% 
  select(year_enrollment)
  highest_total_enrollment_year_2015to2020
  
##how do i get it to select the one value for the highest_enrollment? ^^
  
#Which country had the highest school enrollment in 2019? 
highest_enrollment_country_in_2019 <- enrollment_trends %>% 
  group_by(countrycode) %>% 
  filter(year_enrollment == 2019) %>%
  summarise(school_enrollment_num = enrollment,na.rm = TRUE) %>% 
  filter(school_enrollment_num == max(enrollment)) %>% 
  select(countrycode)
highest_enrollment_country_in_2019

##how do i get it to select the one value for the highest_enrollment_country? ^^

