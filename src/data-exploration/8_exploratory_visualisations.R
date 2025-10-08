# Script: 2_exploratory_visualisations.R
# Goal: Produce exploratory visualisations for the movie dataset


# Load packages
library(tidyverse)
library(broom)

# Ensure output directory exists
if (!dir.exists("../../gen/output")) dir.create("../../gen/output", recursive = TRUE)

# Load dataset
movies <- read_csv("../../gen/temp/movies_prepped.csv")

# 1. Histogram of average IMDb ratings (by movie type)

p1 <- ggplot(movies, aes(x = averageRating, fill = animation_dummy)) +
  geom_histogram(binwidth = 0.1, color = "white") +
  labs(
    x = "Average Rating",
    y = "Count",
    fill = "Type of Movie",
    title = "Distribution of Average IMDb Ratings"
  ) +
  theme_minimal()

ggsave("../../gen/output/hist_average_rating.png", plot = p1, width = 7, height = 5)


# 2. Histogram of number of movies per release year (by movie type)

p2 <- ggplot(movies, aes(x = startYear, fill = animation_dummy)) +
  geom_histogram(binwidth = 1.0, color = "white") +
  labs(
    x = "Release Year",
    y = "Count",
    fill = "Type of Movie",
    title = "Number of Movies Released per Year"
  ) +
  theme_classic()

ggsave("../../gen/output/hist_movies_per_year.png", plot = p2, width = 7, height = 5)



# 3. Summary: ratio of non-animated to animated movies

ratio_summary <- movies %>%
  summarise(ratio = sum(animation_dummy == "Non-Animation") / sum(animation_dummy == "Animation"))
print(ratio_summary)



# 4. Average rating per year (all movies combined)

graph_allmovies <- movies %>%
  group_by(startYear) %>%
  summarise(meanRating = mean(averageRating), .groups = "drop")

p3 <- ggplot(graph_allmovies, aes(x = startYear, y = meanRating)) +
  geom_line(color = "steelblue", linewidth = 1) +
  scale_y_continuous(limits = c(0, 10)) +
  labs(
    x = "Release Year",
    y = "Average IMDb Rating",
    title = "Average Rating per Year (All Movies)"
  ) +
  theme_minimal()

ggsave("../../gen/output/line_avg_rating_all.png", plot = p3, width = 7, height = 5)



# 5. Average rating per year (by animation vs non-animation)

graph_splitmovies <- movies %>%
  group_by(startYear, animation_dummy) %>%
  summarise(meanRating = mean(averageRating), .groups = "drop")

p4 <- ggplot(graph_splitmovies, aes(x = startYear, y = meanRating, color = animation_dummy)) +
  geom_line(linewidth = 1) +
  scale_y_continuous(limits = c(0, 10)) +
  labs(
    x = "Release Year",
    y = "Average IMDb Rating",
    colour = "Type of Movie",
    title = "Average Rating per Year per Type of Movie"
  ) +
  theme_minimal()

ggsave("../../gen/output/line_avg_rating_by_type.png", plot = p4, width = 7, height = 5)



# 6. Smoothed average rating over time (per movie type)

p5 <- ggplot(movies, aes(x = startYear, y = averageRating, colour = animation_dummy)) +
  geom_smooth(se = FALSE, linewidth = 1.2) +
  labs(
    x = "Release Year",
    y = "Average IMDb Rating",
    colour = "Type of Movie",
    title = "Smoothed Trend: Average Rating Over Time by Movie Type"
  ) +
  theme_classic()

ggsave("../../gen/output/smooth_avg_rating_by_type.png", plot = p5, width = 7, height = 5)

# 7. Boxplot of movie runtime (by movie type)

p6 <- ggplot(movies, aes(y = runtimeMinutes, fill = animation_dummy)) +
  geom_boxplot(outlier.alpha = 0.6) +
  labs(
    y = "Runtime (minutes)",
    fill = "Type of Movie",
    title = "Distribution of Movie Runtime by Type"
  ) +
  theme_minimal()

ggsave("../../gen/output/boxplot_runtime.png", plot = p6, width = 7, height = 5)



# End of exploratory visualisation script

cat("Exploratory visualisations successfully saved in ../../gen/output/\n")
