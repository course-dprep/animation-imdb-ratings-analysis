#Script to merge the raw data files

#Load the package
library(tidyverse)

#Load in data
raw_basics <- read.csv("temp/data/raw_basics.csv")
raw_ratings <- read.csv("temp/data/raw_ratings.csv")

#Combine the two datasets into one
raw_combined <- merge(raw_basics, raw_ratings, by = "tconst", all.x = TRUE)

#Save the raw_combined file
write.csv(raw_combined, file = "temp/data/raw_combined.csv", row.names = FALSE)
