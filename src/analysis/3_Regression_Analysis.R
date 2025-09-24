
#A PRELIMINARY and NON-DEFINITIVE but EXPLORATORY analysis

library(tidyverse)
library(broom)
#load definitive dataset
movies <- read_csv("temp/data/movies.csv")

#T-test
ttest <- t.test(averageRating ~ animation_dummy, data = movies)
tidy(ttest) %>% write_csv("temp/output/ttest_animation.csv")
#There is a significant different, which aligns with the higher rating found
#in the previous graph

#General regression 
Regression <- lm(averageRating ~ startYear*animation_dummy, data = movies)
summary(Regression)

#Regression including control variables
CV_regression <- lm(averageRating ~ startYear*animation_dummy + runtimeMinutes + numVotes, data = movies)
summary(CV_regression)

tidy(Regression) %>% write_csv("temp/output/regression_baseline.csv")
tidy(CV_regression) %>% write_csv("temp/output/regression_with_controls_variables.csv")

# In the data preparation pipeline, we already created the dummy variable 
# 'before_2010_dummy' (Release before 2010 vs Release since 2010).
# Here, we use this dummy directly in regression models to test whether
# the relationship between movie type (Animation vs Non-Animation) 
# and IMDb ratings differs before and after 2010.
#
# Note: Subsetting and descriptive statistics for these groups were 
# already performed in earlier pipeline steps, so we do not repeat them here.

#General regression 
Regression_Releaseyeardummy <- lm(averageRating ~ before_2010_dummy*animation_dummy, data = movies)
summary(Regression_Releaseyeardummy)

#Regression including control variables
CV_regression_Releaseyeardummy <- lm(averageRating ~ before_2010_dummy*animation_dummy + runtimeMinutes + numVotes, data = movies)
summary(CV_regression_Releaseyeardummy)

tidy(Regression_Releaseyeardummy) %>% write_csv("temp/output/regression_before2010.csv")
tidy(CV_regression_Releaseyeardummy) %>% write_csv("temp/output/regression_before2010_controls.csv")
