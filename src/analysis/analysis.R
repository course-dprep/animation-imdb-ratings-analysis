################################
#PIPELINE STEP: DATA EXPLORATION
################################

library(tidyverse)
library(ggplot2)

#Read in the definitive dataset
movies <- read_csv("data/movies.csv")

#Inspecting definitive dataset
summary(movies)
table(movies$animation_dummy)

#Creating subset of animation for further inspection
animation_subset <- movies %>% 
  filter(animation_dummy == "Animation")

#Creating subset of non-animation for further inspection
non_animation_subset <- movies %>% 
  filter(animation_dummy == "Non-Animation")

#Creating a function for efficiency
inspect_data <- function(df) {
  cat("Generating descriptive statistics...\n\n")
  cat("\n\n")
  
  cat('Summary statistics\n')
  print(summary(df))
  cat('\n\n')
  
  cat('Number of observations in subset: ')
  cat(nrow(df))
  cat('\n\n')
  
  cat('Range in runtime:\n')
  print(max(df$runtimeMinutes) - min(df$runtimeMinutes))
  cat('\n\n')
  
  cat('Standard deviation of runtime:\n')
  print(sd(df$runtimeMinutes))
  cat('\n\n')
  
  cat('Range in average rating:\n')
  print(max(df$averageRating) - min(df$averageRating))
  cat('\n\n')
  
  cat('Standard deviation of average rating:\n')
  print(sd(df$averageRating))
  cat('\n\n')
  
  cat('Range in number of votes:\n')
  print(max(df$numVotes) - min(df$numVotes))
  cat('\n\n')
  
  cat('Standard deviation of number of votes:\n')
  print(sd(df$numVotes))
  cat('\n\n')
  
}

#Above can now be used to check both subsets
inspect_data(animation_subset)
inspect_data(non_animation_subset)

#Above are basic figures, now the plots and figures are next.


#Frequencies: histogram of average rating together
ggplot(movies, aes(x=averageRating, fill = animation_dummy)) + 
  geom_histogram(binwidth = 0.1)

#Frequencies: histogram of number of movies per year split
ggplot(movies, aes(x=startYear, fill = animation_dummy)) + 
  geom_histogram(binwidth = 1.0) +
  theme_classic()
#Output aligns with expectation; increase in movies over the years, but seems more
#linear than exponential despite streaming in 2010. Overall, more animation movies
#in the dataset. See:
movies %>% 
  summarise(
    ratio = sum(animation_dummy == "Non-Animation") / sum(animation_dummy == "Animation")
  )

#Frequencies: average rating per year
graph_allmovies <- movies %>% 
  group_by(startYear) %>% 
  summarise(meanRating = mean(averageRating, na.rm = TRUE))

ggplot(graph_allmovies, aes(x=startYear, y=meanRating)) + geom_line()

#Frequencies: average rating per year per type of movie (animation or not)
graph_splitmovies <- movies %>% 
  group_by(startYear, animation_dummy) %>% 
  summarise(meanRating = mean(averageRating, na.rm = TRUE), .groups = "drop")

ggplot(graph_splitmovies, aes(x=startYear, y=meanRating, 
                              color = animation_dummy)) + 
                              geom_line() + 
                              labs(x = "Release Year", 
                                   y = "Average IMDb Rating", 
                                   colour = "Type of Movie") + 
                              theme_minimal()

#Frequency: alternative graph for rating over time for both categories
ggplot(movies, aes(x = startYear, y = averageRating, colour = animation_dummy)) +
  geom_smooth() +
  labs (x = "Year", y = "Average IMDb Rating",
        title = "Average rating over time per movie type",
        colour = "Type of Movie") +
  theme_classic()

#Frequencies: boxplot of runtime in minutes
ggplot(movies, aes(y = runtimeMinutes, fill = animation_dummy)) + geom_boxplot()











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

#Next sections to be worked out are related to the ASSUMPTIONS
#That is for later

library(e1071)
skewness(movies$averageRating)