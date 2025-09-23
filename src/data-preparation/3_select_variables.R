#Script to clean the raw data files

#Load the package
library(tidyverse)

#Load the raw_combined data
raw_combined <- read_csv("temp/data/raw_combined.csv")

#Selecting the variables relevant to analysis to keep an overview
#Note: Variables removed are; "titleType", "originalTitle", "isAdult", "endYear"
movies_v1 <- raw_combined %>% select(tconst,
                                     primaryTitle,
                                     startYear, 
                                     runtimeMinutes, 
                                     genres, 
                                     averageRating, 
                                     numVotes)

#Set variables right; convert character variable to numeric
movies_v1$startYear <- as.numeric(raw_combined$startYear)
movies_v1$runtimeMinutes <- as.numeric(raw_combined$runtimeMinutes)

#Save the dataset locally
write.csv(raw_basics, file = "temp/data/movies_v1.csv")







