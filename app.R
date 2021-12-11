#app.R 

library(shiny)

source("app_ui.R", local=TRUE)
source("app_server.R", local=TRUE)

#insert dataset
# country_data <- read.csv("https://raw.githubusercontent.com/worldbank/school-survey/master/01_data/011_rawdata/wbg_country_metadata.csv")
# school_data <- read.csv("https://raw.githubusercontent.com/worldbank/school-survey/master/01_data/011_rawdata/enrollment.csv")
# vacc <- read.csv("COVID-19_Vaccination_and_Case_Trends.csv")
# Colleges <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/colleges/colleges.csv")
# testingpolicies <- read.csv("covid-19-testing-policy.csv")

shinyApp(ui = ui, server = server)