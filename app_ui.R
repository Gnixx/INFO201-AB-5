library(shiny)
library(dplyr)
library(plotly)

# introduction
introductionTab <- tabPanel(
  "Introduction",
  titlePanel(h3("Introduction: Covid Affecting Education")),
  img(src = "COVID-19.png", height = 140, width = 400),
  p("Due to  the school closures during COVID-19, over a billion children are at
    risk of falling behind in school. To keep students safe, countries have implemented
    virtual learning and we believe that this change has affected countless students.
    Our group wanted to explore this domain more, as we are all students pursuing higher
    education. We tried to look at the impacts of COVID-19 on the global education
    system to see if there were any national trends correlated with Covid-19."),
  p(strong("There are some data-driven questions we wish to answer:")),
  tags$ul(
    tags$li(p("How did students perform during school closures?")),
    tags$li(p("How many students are unable to set up online learning platforms? Why?")),
    tags$li(p("How did changing COVID-19 testing policies affect the number of cases in the US?")),
    tags$li(p("Did the amount of time that a country held a certain COVID-19 testing policy
            have an association with the number of school closures there were?")),
    tags$li(p("Which age group had a higher percentage of people who took both doses
            of the vaccination?")),
  ),
  p(),
  p(strong("We studied three datasets in this project. They are:")),
  tags$ul(
    tags$li(
      p("National Education Responses to COVID-19 School Closures"),
      a(href = "https://en.unesco.org/sites/default/files/duration_school_closures.csv", "Click here for data!")
    ),
    p(),
    p("The data was collected by the following organizations Scientific and Cultural
    Organization (UNESCO), the United Nations Children's Fund (UNICEF), the World
    Bank, and the Organization for Economic Co-operation and Development (OECD)
    conducted a Survey on National Education Responses to COVID-19 School Closures."),
    p("This dataset answers a few questions:"),
    tags$ul(
      tags$li(p("What is the longest duration of time that students did online learning?")),
      tags$li(p("Which countries had the longest duration of school closures?")),
    ),
    p(),
    tags$li(
      p("COVID-19 Vaccination and Case Trends by Age Group, United States"),
      a(href = "https://data.cdc.gov/Vaccinations/COVID-19-Vaccination-and-Case-Trends-by-Age-Group-/gxj9-t96f", "Click here for data!")
    ),
    p("The data was collected by the Centers for Disease Control and Prevention (CDC).
      CDC uses both new and existing information technology to quickly collect data
      about the distribution and administration of COVID-19 vaccines."),
    p(),
    p("This data has 2925 observations (still updating)"),
    p("This dataset answers a few questions:"),
    tags$ul(
      tags$li(p("How did the situation of vaccination affect the recovery of education?")),
      tags$li(p("How did the number of new cases affect the recovery of education?")),
      tags$li(p("Did age group 12-17 or 18-24 have a higher percentage of the population
              who got Dose 1 of their Covid-19 vaccination?")),
    )
  )
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
  titlePanel(h3("COVID-19 Vaccination and
                Case Trends by Age Group, United States")),
  chart_sidebar,
  chart_main
)

schoolClosureSidebar <- sidebarPanel(
  sliderInput("top", "Select your top", min = 20, max = 40, value = 20)
)

schoolClosureMain <- mainPanel(
  plotlyOutput("schoolClosure")
)

schoolPanel <- tabPanel(
  "School Closure",
  titlePanel(h3("School Closure")),
  schoolClosureSidebar,
  schoolClosureMain
)


# # # Pie Chart
testingPolicies <- sidebarPanel(
  sliderInput("slider1",
    label = "Amount of Countries", min = 0,
    max = 100, value = 10
  )
)

testingPoliciesMain <- mainPanel(
  plotlyOutput("pie"),
  p("This pie chart is depicting the countries who have held
    the highest level of Covid Testing policies (3), which
    means that tests are avaliable to everyone, whether they
    have symptoms or not. When you select a random amount of countries,
    you can see which ones have held this universal policy for the longest.")
)

testingPanel <- tabPanel(
  "Testing Policies",
  titlePanel(h3("Highest Testing Policies")),
  testingPolicies,
  testingPoliciesMain
)

# conclusion
conclusionTab <- tabPanel(
  "Conclusion",
  titlePanel(h3("Conclusion")),
  plotlyOutput("map"),
  p("One key takeaway from the school closures dataset was how the data
  collected is not always what you expect it to be. For example, looking at
  the top 20 countries with school closures, we were looking for any patterns
  with a higher number of school closures within a certain geographic area.
  However, it was more widespread than we thought. Since China's school closures
  were within the top 20 countries, we expected more East Asian countries
  in the top 20 countries with school closures than were actually listed
  in our chart."),
  p("A second takeaway coming from the Vaccinations dataset was
  more people in both age groups 12-17 and 18-24 had a higher percentage of
  the population taking Dose 1 rather than completing both doses. Within these
  two age groups, it surprised us that the group ages 12-17 had a higher
  percentage of the population getting their first dose."),
  p("A takeaway we had from the Covid-19 testing policy dataset
  was how long testing policy 3 was available to people and how Covid-19
  tests were becoming more readily available to the general population overtime.
  Testing policy 3 allowed for more people to gain access to Covid-19 testing
  which also had an effect on reopenings of schools for each country. However,
  a lot of countries like Austrailia still had more limited testing
  options overtime. One finding that we found surprising was that France was one
  of the countries that had one of the longest school closures, while also
  having high test policies. This means that having more access to Covid
  testing didn't necessarily guarentee short school closures.")
)

# ui
ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    "Final Deliverable",
    introductionTab,
    timeline_panel,
    schoolPanel,
    testingPanel,
    conclusionTab
  )
)
