#Script to run the t-test

#load the library
library(tidyverse)

#Load the dataset
movies <- read_csv("../../gen/temp/movies_prepped.csv")

#T-test
ttest <- t.test(averageRating ~ animation_dummy, data = movies)

#Save the results of the t-test locally
capture.output(ttest, file = "../../gen/output/ttest_rating.txt")
