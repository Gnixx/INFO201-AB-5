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
  p("National Education Responses to COVID-19 School Closures", a(href="..", "Click here for data!")), 
  p("COVID-19 Vaccination and Case Trends by Age Group, United States", a(href="..", "Click here for data!")),
  p("COVID-19 Testing Policities Tracking Covid-19 at U.S. Collegtes and Universities", a(href="..", "Click here for data!")),
  p(""),
  p("The total school enrollment in 2020 was")
)

testingpolicies <- read_csv("covid-19-testing-policy.csv")
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
  p("School closures: One key takeaway from our project was that our data was very inconclusive.
    the data exposes information about national education responses to school
    closures due to COVID-19 pandemic. This specific data was collected between
    February and May 2021. It shows the government responses to school (from preschool to secondary) closures.. 
    We learned that schools began to reopen the more vaccinations were
    available and being given out to patients."),
  p("National trends in vaccinations and cases of covid-19 grouped by age.jkfhskfjk: nfaknfsnsnfsll."),
  p("Contains lots of information pertaining to government’s response to Covid-19, including covid
    testing availability, school closures, travel restriction and vaccination rates and availability. We learned that policies starting increasing in number when vaccinations were administered."),
  p("Lastly, as a team, we learned how important communication is when working in 
    seperate files and merging them together at the same time.")
)

# ui
ui <- navbarPage(
  "Final Deliverable",
  introductionTab,
  pie_panel,
  conclusionTab,
)