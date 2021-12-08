# introduction
introductionTab <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  p("filler text.")
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
  conclusionTab,
)