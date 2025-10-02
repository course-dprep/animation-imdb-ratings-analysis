#Script to run the linear regression model

#Load packages
library(tidyverse)
library(lm.beta)

#Load definitive dataset
movies <- read_csv("../../gen/output/movies.csv")

#Ensure the dummies are treated as categorical variables
movies$before_2010_dummy <- as.factor(movies$before_2010_dummy)
movies$animation_dummy <- as.factor(movies$animation_dummy)

#Model with basic variables
MODEL1_unstandardised <- lm(averageRating ~ before_2010_dummy + animation_dummy, data = movies); summary(MODEL1_unstandardised)
MODEL1 <- lm.beta(MODEL1_unstandardised); summary(MODEL1)
capture.output(summary(MODEL1), file = "../../gen/output/lr_model_basic.txt")

#Model with basic + control variables
MODEL2_unstandardised <- lm(averageRating ~ before_2010_dummy + animation_dummy + startYear + log_runtimeMinutes + log_numVotes, data = movies); summary(MODEL2_unstandardised)
MODEL2 <- lm.beta(MODEL2_unstandardised); summary(MODEL2)
capture.output(summary(MODEL2), file = "../../gen/output/lr_model_with_control_variables.txt")

#Model with basic + control + interactions
MODEL3_unstandardised <- lm(averageRating ~ before_2010_dummy*animation_dummy + animation_dummy*startYear + log_runtimeMinutes + log_numVotes, data = movies); summary(MODEL3_unstandardised)
MODEL3 <- lm.beta(MODEL3_unstandardised); summary(MODEL3)
capture.output(summary(MODEL3), file = "../../gen/output/lr_model_with_extra_dummy.txt")

#Save the regressions locally
saveRDS(MODEL1_unstandardised, "../../gen/output/MODEL1_unstandardised.rds")
saveRDS(MODEL2_unstandardised, "../../gen/output/MODEL2_unstandardised.rds")
saveRDS(MODEL3_unstandardised, "../../gen/output/MODEL3_unstandardised.rds")
