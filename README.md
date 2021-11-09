# Project Proposal
Group: INFO201 AB 5

Members: Rena, Amanda, Jasmine, Debbie, August

### Domain of interest
- **Why are you interested in this field/domain?**
  - According to UNICEF, more than a billion children are at risk of falling behind from school due to school closures during COVID-19. To keep students safe, countries have implemented virtual learning. Not only does our domain affect billions of people, but it also seems very relevant to our group, as we are all students pursuing higher education.

- **What other examples of data driven project have you found related to this domain (share at least 3)?**
  - Unesco collected data monitoring school closures globally due to COVID-19 and their impact on learners.
  - Another study conducted by Unesco looked at the total duration of school closures during the pandemic and how this number .
  - A study by the Economic Policy Institute researched how learning and online  instruction during the pandemic has affected engagement, teaching, and learning.
  - The CDC did a study on vaccination coverage among adolescents from the ages 13-17.

- **What data-driven questions do you hope to answer about this domain (share at least 3)?**
  - What is the total number of the affected students?
  - What is the percentage of students unenrolled?
  - What is the longest duration of time that students did online learning?
  - What country has the lowest number of affected students?
  - What country has the highest number of affected students?
  - How did students perform during school closures?
  - What did schools do in response to school closures and student performance?
  - How many students are unable to set up online learning platforms? Why?
  - What did we learn from these datasets?
  - How did the situation of vaccination affect the recovery of education?
  - How did changing COVID-19 testing policies affect the number of cases in the US?
  - Which university within Washington state had the highest number of total Covid cases?
  - Which university had the highest number of cases in 2021?


### Finding Data
- **Where did you download the data (e.g., a web URL)?**
  - [National Education Responses to COVID-19 School Closures](https://github.com/worldbank/school-survey/tree/master/01_data/011_rawdata)
  - [COVID-19 Vaccination and Case Trends by Age Group, United States](https://data.cdc.gov/Vaccinations/COVID-19-Vaccination-and-Case-Trends-by-Age-Group-/gxj9-t96f)
  - [COVID-19 Testing PoliciesTracking Covid-19 at U.S. Colleges and Universities](https://github.com/nytimes/covid-19-data/tree/master/colleges)

- **_National Education Responses to COVID-19 School Closures_**
  - **Who:** The data was collected by the following organizations Scientific and Cultural Organization (UNESCO), the United Nations Children's Fund (UNICEF), the World Bank, and the Organization for Economic Co-operation and Development (OECD) conducted a Survey on National Education Responses to COVID-19 School Closures.
  - **How:** The data was collected through a series of three surveys about National Education Responses to COVID-19 School Closures.
  - **What is the data about:** The data exposes information about national education responses to school closures due to COVID-19 pandemic. This specific data was collected between February and May 2021. It shows the government responses to school (from preschool to secondary) closures.
  - **Number of observations:** 104 observations from 143 countries that responded to the survey.
  - **Number of features:** 65 features from 143 countries that responded to the survey.
  - **What questions (from above) can be answered using the data in this dataset?**
    - What is the longest duration of time that students did online learning?
    - What country has the lowest number of affected students?
    - What country has the highest number of affected students?
    - What did schools do in response to school closures and student performance?
    - What did we learn from these datasets?


- **_COVID-19 Vaccination and Case Trends by Age Group, United States_**
  - **Who:** CDC (Centers for Disease Control and Prevention)
  - **How:** CDC uses both new and existing information technology to quickly collect data about the distribution and administration of COVID-19 vaccines.
  - **What is the data about:** National trends in vaccinations and cases of covid-19 grouped by age.
  - **Number of observations:** 2925 (keep updating)
  - **Number of features:** 5
    - Date Administered -- Best available date related to illness/specimen collection and when a case is reported.
    - AgeGroupVacc -- Age group specifics for vaccination data
    - 7-day_avg_group_cases_per_100k -- 7 day average of the daily cases reported
    - Administered_Dose1_pct_agegroup -- Percent of population with at lease one dose in that specific age group
    - Series_Complete_Pop_pct_agegroup -- Percent of people who are fully vaccinated (have second dose of a two-dose vaccine or one dose of a single-dose vaccine) in that specific age group
  - **What questions (from above) can be answered using the data in this dataset?**
    - How did the situation of vaccination affect the recovery of education?
    - How did the number of new cases affect the recovery of education?


- **_COVID-19 Testing PoliciesTracking Covid-19 at U.S. Colleges and Universities_**
  - **Who:** Thomas Hale, Noam Angrist, Rafael Goldszmidt, Beatriz Kira, Anna Petherick, Toby Phillips, Samuel Webster, Emily Cameron-Blake, Laura Hallas, Saptarshi Majumdar, and Helen Tatlow.
  - **How:** Data collected by Oxford volunteers across the world, and logged continuously into the OxCGRT (oxford covid govt response tracker)
  - **What is the data about:** The data contains lots of information pertaining to government’s response to Covid-19, including covid testing availability, school closures, travel restriction and vaccination rates and availability.
  - **Number of observations:** 123495 (continues updating)
  - **Number of features:** 4 - Country, country abbreviation, date, and testing policy level (0-3)
  - **What questions (from above) can be answered using the data in this dataset?**
    - How countries rank with combined restrictions?
    - What level of specific restrictions each country has?
      - school and workplace closures, (fully shut down, some open, all open)
      - internal and external travel
      - Restrictions on gathering
      - Stay at home order, face coverings (recommended to required)
