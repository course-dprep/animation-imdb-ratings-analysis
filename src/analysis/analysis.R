################################
#PIPELINE STEP: DATA EXPLORATION
################################

#Read in the definitive dataset
movies <- read_csv("data/movies.csv")

#Overview of definitive dataset
summary(movies)

#Frequencies: histogram of ratings
ggplot(movies, aes(x=averageRating)) + geom_histogram()

#Frequencies: histogram of number of movies per year
ggplot(movies, aes(x=startYear)) + geom_histogram()
#COMMENT; WHY IS THERE SUCH A DROP AFTER THE FIRST YEAR?

#Frequencies: histogram of animation vs non-animation
ggplot(movies, aes(x=animation_dummy)) + geom_bar()
#COMMENT; IS THIS GRAPH REALLY TELLING SOMETHING VALUABLE? 
#WHAT ABOUT A RATIO INSTEAD?
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
                              labs(x = "Release Year", y = "Average IMDb Rating", colour = "Type of Movie") + 
                              theme_minimal()

#Frequencies: boxplot of runtime in minutes
ggplot(movies, aes(y = runtimeMinutes)) + geom_boxplot()





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