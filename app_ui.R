library(shiny)
library(plotly)

# introduction
introductionTab <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  h3("(Name of Project)"),
  p("Due to  the school closures during COVID-19, over a billion children are at
    risk of falling behind in school. To keep students safe, countries have implemented
    virtual learning and we believe that this change has affected countless students.
    Our group wanted to explore this domain more, as we are all students pursuing higher
    education. We tried to look at the impacts of COVID-19 on the global education
    system to see if there were any national trends correlated with Covid-19."),
  p("For this project, we looked at three datasets. They are:"),
  p("National Education Responses to COVID-19 School Closures", a(href = "..", "Click here for data!")),
  p("COVID-19 Vaccination and Case Trends by Age Group, United States", a(href = "..", "Click here for data!")),
  p("COVID-19 Testing Policities Tracking Covid-19 at U.S. Collegtes and Universities", a(href = "..", "Click here for data!")),
  p(""),
  p("The total school enrollment in 2020 was")
)


# chart panel
## chart sidebar
chart_sidebar <- sidebarPanel(
  age_input <- selectInput(
    inputId = "age",
    label = "Age Group",
    choices = list(
      "<12 Years" = "<12 Years",
      "12 - 15 Years" = "12 - 15 Years",
      "16 - 17 Years" = "16 - 17 Years",
      "18 - 24 Years" = "18 - 24 Years"
    )
  )
)

## chart mainbar
chart_main <- mainPanel(
  plotlyOutput("Timeline")
)

timeline_panel <- tabPanel(
  "Timeline",
  titlePanel("COVID-19 Vaccination and Case Trends by Age Group, United States"),
  chart_sidebar,
  chart_main
)


# Pie Chart
testingpolicies <- read_csv("docs/covid-19-testing-policy.csv")
pie_sidebar_content <- sidebarPanel(
  selectInput(
    label = "choose country",
    choices = country$Entity,
    inputId = "countrychoice"
  )
)

pie_main_content <- mainPanel(
  plotlyOutput("pie")
)

pie_panel <- tabPanel(
  "Pie Chart",
  # titlePanel("Countries with highest level testing policy; by time"),
  sidebarLayout(
    pie_sidebar_content,
    pie_main_content
  )
)

# conclusion
conclusionTab <- tabPanel(
  "Conclusion",
  titlePanel("Conclusion"),
  p("One key takeaway from the school closures dataset was how the data
  collected is not always what you expect it to be. For example, looking at
  the top 20 countries with school closures, we were looking for any patterns
  with a higher number of school closures within a certain geographic area.
  However, it was more widespread than me thought. Since China's school closures
  were within the top 20 countries, we expected more East Asian countries
  in the top 20 countries with school closures than were actually listed
  in our chart."),
  p("A second takeaway coming from the Vaccinations dataset was
  more people in both age groups 12-17 and 18-24 had a higher percentage of
  the population taking Dose 1 rather than completing both doses. Within these
  two age groups, it surprised us that the group ages 12-17 had a higher
  percetage of the population getting their first dose."),
  p("A takeaway we had from the Covid-19 testing policy dataset
  was how long testing policy 3 was available to people and how Covid-19
  tests were becoming more readily available to the general population overtime.
  Testing policy 3 allowed for more people to gain access to Covid-19 testing
  which also had an effect on reopenings of schools for each country. However,
  a lot of countries like Austrailia still had more limited testing
  options overtime.")
)

# ui
ui <- navbarPage(
  "Final Deliverable",
  introductionTab,
  timeline_panel,
  pie_panel,
  conclusionTab,
)
