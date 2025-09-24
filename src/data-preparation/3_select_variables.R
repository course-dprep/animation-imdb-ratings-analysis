#Script to select variables from the raw data file relevant to analysis

#Load the package
library(tidyverse)

#Load the raw_combined data
raw_combined <- read_csv("gen/temp/raw_combined.csv")

#Verifying whether the only featured type of content are 'movies'
table(raw_combined$titleType)
#Only movies are in the dataset, which aligns with the focus of the study

#Selecting the remaining variables relevant to analysis to keep an overview
#Note: Variables removed are; "titleType", "originalTitle", "isAdult", "endYear"
movies_selected <- raw_combined %>% select(tconst,
                                     primaryTitle,
                                     startYear, 
                                     runtimeMinutes, 
                                     genres, 
                                     averageRating, 
                                     numVotes)

#Set variables right; convert character variable to numeric
movies_selected$startYear <- as.numeric(raw_combined$startYear)
movies_selected$runtimeMinutes <- as.numeric(raw_combined$runtimeMinutes)

#Save the dataset locally
write.csv(movies_selected, file = "gen/temp/movies_selected.csv", row.names = FALSE)






