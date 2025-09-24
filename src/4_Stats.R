#A PRELIMINARY and NON-DEFINITIVE but EXPLORATORY analysis
#Just to get a feeling with it

#T-test
t.test(averageRating ~ animation_dummy, data = movies)
#There is a significant different, which aligns with the higher rating found
#in the previous graph

#General regression 
Regression <- lm(averageRating ~ startYear*animation_dummy, data = movies)
summary(Regression)

#Regression including control variables
CV_regression <- lm(averageRating ~ startYear*animation_dummy + runtimeMinutes + numVotes, data = movies)
summary(CV_regression)

#Now, we will change the variable startYear to a dummy, where a movie is released
#either before or since 2010. This because in 2010, streaming platforms gained
#a more dominant position into the movie market.

#Creating subset of release year before 2010 for further inspection
before_2010_subset <- movies %>% 
  filter(before_2010_dummy == "Release before 2010")

#Creating subset of non-animation for further inspection
since_2010_subset <- movies %>% 
  filter(before_2010_dummy == "Release since 2010")

#General inspection of subsets above
inspect_data(before_2010_subset)
inspect_data(since_2010_subset)

#General regression 
Regression_Releaseyeardummy <- lm(averageRating ~ before_2010_dummy*animation_dummy, data = movies)
summary(Regression_Releaseyeardummy)

#Regression including control variables
CV_regression_Releaseyeardummy <- lm(averageRating ~ before_2010_dummy*animation_dummy + runtimeMinutes + numVotes, data = movies)
summary(CV_regression_Releaseyeardummy)

#Next sections to be worked out are related to the ASSUMPTIONS
#That is for later

install.packages("e1071")
library(e1071)
skewness(movies$averageRating)
