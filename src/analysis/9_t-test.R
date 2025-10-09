#Script to run the t-test

#load the library
library(tidyverse)

#Load the dataset
movies <- read_csv("../../gen/temp/movies_prepped.csv")

#T-test
ttest <- t.test(averageRating ~ animation_dummy, data = movies)

#Save the results of the t-test locally
sink("../../gen/output/ttest_rating.txt", split = TRUE)
print(ttest)
sink()

#T-test
ttest2 <- t.test(averageRating ~ before_2010_dummy, data = movies)

#Save the results of the t-test locally
sink("../../gen/output/ttest_release.txt", split = TRUE)
print(ttest2)
sink()