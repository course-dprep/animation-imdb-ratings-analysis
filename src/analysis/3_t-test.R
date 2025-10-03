#Script to run the t-test

#load the library
library(tidyverse)

#Load the dataset
movies <- read_csv("../../gen/temp/movies_prepped.csv")

#T-test
ttest <- t.test(averageRating ~ animation_dummy, data = movies)
#There is a significant different, which aligns with the higher rating found
#in the previous graph

#Save the results of the t-test locally
tidy(ttest) %>% write_csv("../../gen/output/ttest_rating.csv")
