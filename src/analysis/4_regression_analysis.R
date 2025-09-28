#Script to run the linear regression model

#Load packages
library(tidyverse)

#Load definitive dataset
movies <- read_csv("../../gen/output/movies.csv")

#Model including basic variables
version1 <- lm(averageRating ~ startYear*animation_dummy, data = movies); summary(version1)
capture.output(summary(version1), file = "../../gen/output/lr_model_basic.txt")
save(version1, file = "../../gen/temp/version1.RData")


#Model including basic + control variables
version2 <- lm(averageRating ~ startYear*animation_dummy + log_runtimeMinutes + log_numVotes, data = movies); summary(version2)
capture.output(summary(version2), file = "../../gen/output/lr_model_with_control_variables.txt")
save(version2, file = "../../gen/output/version1.RData")

#Both F-statistic and adjusted R2 is higher for version2, so this is a better model.

#Model including basic + control + extra dummy release year
version3 <- lm(averageRating ~ startYear*animation_dummy*before_2010_dummy + log_runtimeMinutes + log_numVotes, data = movies); summary(version3)




# In the data preparation pipeline, we already created the dummy variable 
# 'before_2010_dummy' (Release before 2010 vs Release since 2010).
# Here, we use this dummy directly in regression models to test whether
# the relationship between movie type (Animation vs Non-Animation) 
# and IMDb ratings differs before and after 2010.
#
# Note: Subsetting and descriptive statistics for these groups were 
# already performed in earlier pipeline steps, so we do not repeat them here.

#General regression 
Regression_Releaseyeardummy <- lm(averageRating ~ before_2010_dummy*animation_dummy, data = movies); summary(Regression_Releaseyeardummy)

#Regression including control variables
CV_regression_Releaseyeardummy <- lm(averageRating ~ before_2010_dummy*animation_dummy + runtimeMinutes + numVotes, data = movies); summary(CV_regression_Releaseyeardummy)

tidy(Regression_Releaseyeardummy) %>% write_csv("../../gen/output/regression_before2010.csv")
tidy(CV_regression_Releaseyeardummy) %>% write_csv("../../gen/output/regression_before2010_controls.csv")
