#Script to check the assumptions of variables to determine the regression model

#Load packages
library(tidyverse)
library(patchwork)   # for combining plots

#Load data
movies <- read_csv("../../gen/output/movies_prepped.csv")


#1. NORMALITY
#Check DV for Normality
p_numVotes_raw1 <- movies %>% 
  ggplot(aes(x = averageRating)) +
  geom_histogram(binwidth = 0.1, fill = "purple", color = "white") +
  xlim(0, 10)
p_numVotes_raw1


#2. LINEARITY
#Create function to check assumption of linearity
linearity_check <- function(data, predictor, outcome = "averageRating") {
  ggplot(data, aes(x = .data[[predictor]], y = .data[[outcome]])) +
    geom_point(alpha = 0.2) +
    geom_smooth(method = "loess", se = FALSE, color = "red") +
    labs(
      title = paste("Linearity check:", predictor, "vs", outcome),
      x = predictor,
      y = outcome
    ) +
    theme_minimal()
}

#Run function per predictor
linearity_check(movies, "numVotes")
linearity_check(movies, "runtimeMinutes")
linearity_check(movies, "startYear")

#NumVotes violates Linearity, executing log transformation
movies <- movies %>%
  mutate(log_numVotes = log(numVotes))

#Save file locally that will be used in the regression
write.csv(movies, file = "../../gen/output/movies_transformed.csv", row.names = FALSE)

