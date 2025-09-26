# Assumptions check pre regression model
# Check these assumptions before starting the regression:
# 1. Linearity
# 2. Normality of residuals

library(tidyverse)
library(patchwork)   # for combining plots

# Load data
movies <- read_csv("gen/output/movies.csv")

###########################################
# 1. LINEARITY CHECK (raw variables)
###########################################

p_numVotes_raw <- ggplot(movies, aes(numVotes, averageRating)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs(title = "Linearity check: numVotes (raw)")

p_runtime_raw <- ggplot(movies, aes(runtimeMinutes, averageRating)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs(title = "Linearity check: runtimeMinutes (raw)")

p_startYear_raw <- ggplot(movies, aes(startYear, averageRating)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs(title = "Linearity check: startYear (raw)")

(p_numVotes_raw | p_runtime_raw | p_startYear_raw)

norm



###########################################
# 2. TRANSFORMATIONS
###########################################

movies <- movies %>%
  mutate(
    logVotes   = log1p(numVotes),         # log(1+x)
    logRuntime = log1p(runtimeMinutes)    # log(1+x)
  )

###########################################
# 3. LINEARITY CHECK (transformed variables)
###########################################

p_numVotes_log <- ggplot(movies, aes(logVotes, averageRating)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs(title = "Linearity check: log(numVotes)")

p_runtime_log <- ggplot(movies, aes(logRuntime, averageRating)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs(title = "Linearity check: log(runtimeMinutes)")

p_startYear <- ggplot(movies, aes(startYear, averageRating)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs(title = "Linearity check: startYear")

(p_numVotes_raw | p_numVotes_log) /
  (p_runtime_raw | p_runtime_log) /
  p_startYear

###########################################
# 4. NORMALITY OF RESIDUALS
###########################################

hist(movies$numVotes, breaks = 50, main = "Histogram numVotes")
hist(movies$runtimeMinutes, breaks = 50, main = "Histogram runtimeMinutes")
hist(movies$averageRating, breaks = 50, main = "Histogram averageRating")

qqnorm(movies$numVotes); qqline(movies$numVotes, col = "red")
qqnorm(movies$runtimeMinutes); qqline(movies$runtimeMinutes, col = "red")
qqnorm(movies$averageRating); qqline(movies$averageRating, col = "red")

install.packages("moments")
library(moments)
skewness(movies$numVotes)
kurtosis(movies$numVotes)

