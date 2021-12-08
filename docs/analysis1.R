# Upload school closure data

# ------Previous links - not enough inf ----------------------------------------
# country_data <- read.csv("https://raw.githubusercontent.com/worldbank/school-survey/master/01_data/011_rawdata/wbg_country_metadata.csv")
# school_data <- read.csv("https://raw.githubusercontent.com/worldbank/school-survey/master/01_data/011_rawdata/enrollment.csv")
# 
# #--------- Save for future work just in case ---------------------------------- 
# school_closures <- school_data %>%
#   left_join(country_data, by = "countrycode")
# 
# # Setting up the data
# group_country <- school_closures %>%
#   group_by(countryname)
# 
# school_enrollment <- school_closures %>%
#   select(countryname, year_enrollment, enrollment, regionname) %>%
#   group_by(year_enrollment) %>%
#   group_by(regionname)  %>%
#   filter(year_enrollment >= 2017)  %>%
#   filter(year_enrollment != 2020)
# 
# school_enrollment1 <- school_enrollment %>%
#   group_by(regionname) %>%
#   filter(year_enrollment == 2017) %>%
#   summarise(enrollmentm_2017 = sum(enrollment))
# 
# school_enrollment2 <- school_enrollment %>%
#   group_by(regionname) %>%
#   filter(year_enrollment == 2019) %>%
#   summarise(enrollmentm_2019 = sum(enrollment))
# 
# region_school_enrollment <- school_enrollment2 %>%
#   select(regionname, enrollmentm_2019) %>%
#   left_join(school_enrollment1,  by = "regionname")

# ------New links - same source ------------------------------------------------
closures <- read.csv("https://en.unesco.org/sites/default/files/duration_school_closures.csv")

# cleaning data - extracting needed rows
closure_duration <- closures %>%
  select(X, X.1, UNESCO.global.dataset.on.the.duration.of.school.closures, X.2) %>%
  slice(-c(1:18)) %>%
  summarise(country_name = X,
            country_code = X.1,
            full_partial_duration_inweeks = UNESCO.global.dataset.on.the.duration.of.school.closures,
            full_closure_inweeks = X.2)

closure_duration_top <- closure_duration %>%
  top_n(20, wt = full_closure_inweeks)

#  Making the plot
closure_duration_plot <- ggplot(data = closure_duration_top) + 
  geom_col(aes(x = country_name, y = full_closure_inweeks, fill = "red")) +
  coord_flip() +
  xlab("Country") + 
  ylab("Weeks") +
  ggtitle("Top 20 Countries with Longest School Closure ")  + 
  scale_fill_manual(values = c("orange4")) +
  theme(legend.position="none")

