#Script to produce exploratory visualisations

#Load the package
library(tidyverse)

#Loading definite dataset
movies <- read_csv("../../gen/output/movies_prepped.csv")

#Simplify the name to allow for more readable code
movies <- movies_prepped

#Frequencies: histogram of average rating together
p1 <- ggplot(movies, aes(x=averageRating, fill = animation_dummy)) + 
  geom_histogram(binwidth = 0.1) +
  labs(x = "Average Rating", y = "Count", fill = "Type of Movie")
ggsave("../../gen/output/hist_average_rating.png", p1, width = 7, height = 5)

#Frequencies: histogram of number of movies per year split
p2 <- ggplot(movies, aes(x=startYear, fill = animation_dummy)) + 
  geom_histogram(binwidth = 1.0) +
  labs(x = "Release Year", y = "Count", fill = "Type of Movie") +
  theme_classic()
ggsave("../../gen/output/hist_movies_per_year.png", p2, width = 7, height = 5)

#Output aligns with expectation; increase in movies over the years, but seems more
#linear than exponential despite streaming in 2010. Overall, more non-animation
#movies in the dataset. See:
ratio <- movies %>% 
  summarise(
    ratio = sum(animation_dummy == "Non-Animation") / sum(animation_dummy == "Animation")
  )
write_csv(ratio, "../../gen/output/ratio_non_vs_animation.csv")

#Frequencies: average rating per year
graph_allmovies <- movies %>% 
  group_by(startYear) %>% 
  summarise(meanRating = mean(averageRating, na.rm = TRUE))

p3 <- ggplot(graph_allmovies, aes(x=startYear, y=meanRating)) + 
  geom_line()+
  labs(x = "Release Year", y = "Average Rating", title = "Average Rating per Year")
ggsave("../../gen/output/line_avg_rating_all.png", p3, width = 7, height = 5)

#Frequencies: average rating per year per type of movie (animation or not)
graph_splitmovies <- movies %>% 
  group_by(startYear, animation_dummy) %>% 
  summarise(meanRating = mean(averageRating, na.rm = TRUE), .groups = "drop")

p4 <- ggplot(graph_splitmovies, aes(x = startYear,
                                    y = meanRating,
                                    color = animation_dummy)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 10)) +     # <<< sets y-axis from 0 to 10
  labs(x = "Release Year",
       y = "Average IMDb Rating",
       colour = "Type of Movie") +
  theme_minimal()

ggsave("../../gen/output/line_avg_rating_by_type.png",
       p4, width = 7, height = 5)

#Frequency: alternative graph for rating over time for both categories
p5 <- ggplot(movies, aes(x = startYear, y = averageRating, colour = animation_dummy)) +
  geom_smooth() +
  labs (x = "Year", y = "Average IMDb Rating",
        title = "Average rating over time per movie type",
        colour = "Type of Movie") +
  theme_classic()
ggsave("../../gen/output/smooth_avg_rating_by_type.png", p5, width = 7, height = 5)

#Frequencies: boxplot of runtime in minutes
p6 <- ggplot(movies, aes(y = runtimeMinutes, fill = animation_dummy)) + 
  geom_boxplot()+
  labs(y = "Runtime (minutes)", fill = "Type of Movie",
       title = "Distribution of Runtime by Movie Type")
ggsave("../../gen/output/boxplot_runtime.png", p6, width = 7, height = 5)





