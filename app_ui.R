library(shiny)
library(plotly)


# introduction
introductionTab <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  h3("Covid Affecting Education"),
  p("Due to  the school closures during COVID-19, over a billion children are at
    risk of falling behind in school. To keep students safe, countries have implemented
    virtual learning and we believe that this change has affected countless students.
    Our group wanted to explore this domain more, as we are all students pursuing higher
    education. We tried to look at the impacts of COVID-19 on the global education
    system to see if there were any national trends correlated with Covid-19."),
  p("There are some examples of data drive project that we found related to this domain:"),
  tags$ul(
    tags$li("Unesco collected data monitoring school closures globally due to
            COVID-19 and their impact on learners"),
    tags$li("Another study conducted by Unesco looked at the total duration of school
            closures during the pandemic and how this number"),
    tags$li("A study by the Economic Policy Institute researched how learning and online
            instruction during the pandemic has affected engagement, teaching, and learning"),
    tags$li("The CDC did a study on vaccination coverage among adolescents from the ages 13-17")
  ),
  p("There are some data-driven questions we wish to answer:"),
  tags$ul(
    tags$li("What is the total number of the affected students?"),
    tags$li("What is the percentage of students unenrolled?"),
    tags$li("How did students perform during school closures?"),
    tags$li("How many students are unable to set up online learning platforms? Why?"),
    tags$li("How did changing COVID-19 testing policies affect the number of cases in the US?")
  ),
  p(),
  p("We studied three datasets in this project. They are:"),
  tags$ul(
    tags$li(
      "National Education Responses to COVID-19 School Closures",
      a(href = "https://en.unesco.org/sites/default/files/duration_school_closures.csv", "Click here for data!")
    ),
    p(),
    p("The data was collected by the following organizations Scientific and Cultural
    Organization (UNESCO), the United Nations Children's Fund (UNICEF), the World
    Bank, and the Organization for Economic Co-operation and Development (OECD)
    conducted a Survey on National Education Responses to COVID-19 School Closures."),
    p("This dataset answers a few questions:"),
    tags$ul(
      tags$li("What is the longest duration of time that students did online learning?"),
      tags$li("What country has the lowest number of affected students?"),
      tags$li("What country has the highest number of affected students?"),
      tags$li("What did schools do in response to school closures and student performance?"),
      tags$li("What did we learn from these datasets?")
    ),
    p(),
    tags$li(
      "COVID-19 Vaccination and Case Trends by Age Group, United States",
      a(href = "https://data.cdc.gov/Vaccinations/COVID-19-Vaccination-and-Case-Trends-by-Age-Group-/gxj9-t96f", "Click here for data!")
    ),
    p("The data was collected by the Centers for Disease Control and Prevention (CDC).
      CDC uses both new and existing information technology to quickly collect data
      about the distribution and administration of COVID-19 vaccines."),
    p(),
    p("This data has 2925 observations (still updating)"),
    p("This dataset answers a few questions:"),
    tags$ul(
      tags$li("How did the situation of vaccination affect the recovery of education?"),
      tags$li("How did the number of new cases affect the recovery of education?")
    ),
    p(),
    tags$li(
      "COVID-19 Testing Policities Tracking Covid-19 at U.S. Collegtes and Universities",
      a(href = "https://github.com/nytimes/covid-19-data/tree/master/colleges", "Click here for data!")
    ),
    p("Data was collected by Oxford volunteers across the world, and logged continuously
      into the OxCGRT (oxford covid govt response tracker)."),
    p("The data contains lots of information pertaining to government’s response to Covid-19,
      including covid testing availability, school closures, travel restriction and
      vaccination rates and availability"),
    p("This dataset answers a few questions:"),
    tags$ul(
      tags$li("How countries rank with combined restrictions?"),
      tags$li("What level of specific restrictions each country has?"),
      tags$ul(
        tags$li("School and workplace closures, (fully shut down, some open, all open)"),
        tags$li("Internal and external travel"),
        tags$li("Restrictions on gathering"),
        tags$li("Stay at home order, face coverings (recommended to required)")
      )
    )
  ),
  p(),
  p()
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

schoolClosureSidebar <- sidebarPanel(
  selectInput(
    inputId = "top",
    label = "the top",
    choices = list(
      "20" = "20",
      "40" = "40"
    ),
    selected = "20"
  )
)

schoolClosureMain <- mainPanel(
  plotlyOutput("schoolClosure")
)

schoolPanel <- tabPanel(
  "School Closure",
  titlePanel("School Closure"),
  schoolClosureSidebar,
  schoolClosureMain
)


# # # Pie Chart


testingPolicies <- sidebarPanel(
  sliderInput("slider1", label = h3("Amount of Countries"), min = 0, 
              max = 100, value = 10)
)

testingPoliciesMain <- mainPanel(
  plotlyOutput("pie")
)

testingPanel <- tabPanel(
  "Highest Testing Policies",
  titlePanel("Highest Testing Policies"),
  testingPolicies,
  testingPoliciesMain
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
  schoolPanel,
  testingPanel,
  conclusionTab,
)
