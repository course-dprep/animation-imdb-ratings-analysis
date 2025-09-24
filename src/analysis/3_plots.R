#Frequencies: histogram of average rating together
ggplot(movies, aes(x=averageRating, fill = animation_dummy)) + 
  geom_histogram(binwidth = 0.1)

#Frequencies: histogram of number of movies per year split
ggplot(movies, aes(x=startYear, fill = animation_dummy)) + 
  geom_histogram(binwidth = 1.0) +
  theme_classic()
#Output aligns with expectation; increase in movies over the years, but seems more
#linear than exponential despite streaming in 2010. Overall, more non-animation
#movies in the dataset. See:
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








