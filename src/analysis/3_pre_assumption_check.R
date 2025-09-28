#Script to check the assumptions of variables that go into the regression model

#Load packages
library(tidyverse)
library(patchwork)   # for combining plots

#Load data
movies <- read_csv("../../gen/temp/movies_prepped.csv")

#Create function to check the assumption of linearity of predictors
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

#Run function for predictor variables
lapply(c("numVotes", "runtimeMinutes", "startYear"),
       function(predictor) linearity_check(movies, predictor))

#Assumption of linearity violated for two variables, solve with log transformation
movies <- movies %>% mutate(log_numVotes = log(numVotes),
                            log_runtimeMinutes = log(runtimeMinutes))

#Save file with transformed variables
write.csv(movies, file = "../../gen/output/movies.csv", row.names = FALSE)
