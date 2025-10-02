#Script to run the linear regression model

#Load packages
library(tidyverse)

#Load definitive dataset
movies <- read_csv("../../gen/output/movies.csv")

#Model with basic variables
model1 <- lm(averageRating ~ startYear*animation_dummy, data = movies); summary(version1)
capture.output(summary(version1), file = "../../gen/output/lr_model_basic.txt")

#Model with basic + control variables
model2 <- lm(averageRating ~ startYear*animation_dummy + log_runtimeMinutes + log_numVotes, data = movies); summary(version2)
capture.output(summary(version2), file = "../../gen/output/lr_model_with_control_variables.txt")

#Model with basic + control + extra dummy release year
model3 <- lm(averageRating ~ startYear*animation_dummy*before_2010_dummy + log_runtimeMinutes + log_numVotes, data = movies); summary(version3)
capture.output(summary(version3), file = "../../gen/output/lr_model_with_extra_dummy.txt")

#Save the regressions locally
saveRDS(model1, "../../gen/output/model1.rds")
saveRDS(model2, "../../gen/output/model2.rds")
saveRDS(model3, "../../gen/output/model3.rds")





#General regression 
model4 <- lm(averageRating ~ before_2010_dummy*animation_dummy, data = movies); summary(model4)

#Regression including control variables
model5 <- lm(averageRating ~ before_2010_dummy*animation_dummy + log_runtimeMinutes + log_numVotes, data = movies); summary(model5)

