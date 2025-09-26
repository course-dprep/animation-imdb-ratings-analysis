# Assumptions check pre regression model
# Check these assumptions before starting the regression:
# 1. Linearity
# 2. Normality of residuals

library(tidyverse)
library(patchwork)   # for combining plots

# Load data
movies <- read_csv("../../gen/output/movies.csv")

# 1. Check DV for Normality
p_numVotes_raw1 <- movies %>% 
  ggplot(aes(x = averageRating)) +
  geom_histogram(binwidth = 0.1, fill = "purple", color = "white") +
  xlim(0, 10)
p_numVotes_raw1

# 2. LINEARITY CHECK
# Functie voor linearity-check
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

# Example: run per predictor
linearity_check(movies, "numVotes")
linearity_check(movies, "runtimeMinutes")
linearity_check(movies, "startYear")

#NumVotes violates Linearity, executing log transformation
movies <- movies %>%
  mutate(log_numVotes = log(numVotes))

#now we create our final movies file to start our regression
write.csv(movies, file = "../../gen/output/movies_transformed.csv", row.names = FALSE)

