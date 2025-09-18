
#Import script is in a different file!

###################################################
#PIPELINE STEP: FROM RAW TO DEFINITIVE DATASET DATA
###################################################

#Load the packages
library(readr) 
library(dplyr)
library(tidyverse)
library(stringr)

#Combine the two datasets into one
raw_combined <- merge(raw_basics, raw_ratings, by = "tconst", all.x = TRUE)

#Save the raw_combined file
write.csv(
  raw_combined,
  file = "data/raw_combined.csv",   #relative path into the data folder
  row.names = FALSE
)

#Set variables right; convert character variable to numeric
raw_combined$startYear <- as.numeric(raw_combined$startYear)
raw_combined$runtimeMinutes <- as.numeric(raw_combined$runtimeMinutes)

#Checking the different types of content
table(raw_combined$titleType)
#Only movies are in the dataset, which aligns with the focus of the study

#Checking the years there is data of
min(raw_combined$startYear, na.rm = TRUE)
max(raw_combined$startYear, na.rm = TRUE)
#The study is interested from the period since the first computer animation 
#released. Therefore, 1995 is taken as the starting point given the release of
#Toy Story. Movies should have been released to ensure consistency across data,
#whereby 2025 is set as the other end for the filter

#Applying the eligibility conditions in a filter to the raw dataset
eligible_data <- filter(raw_combined, startYear >= 1995, startYear <= 2025)

#Selecting the variables relevant to analysis to keep an overview
#Note: Variables removed are; "titleType", "originalTitle", "isAdult", "endYear"
eligible_data <- eligible_data %>% select(tconst,
                                          primaryTitle,
                                          startYear, 
                                          runtimeMinutes, 
                                          genres, 
                                          averageRating, 
                                          numVotes)

#Check whether there are missing values in the dataset
colSums(is.na(eligible_data))

#There are, so remove movies that have missing values in (one of the) variables
#The observations with missing values in averageRating, numVotes, and runtimeMinutes 
#were removed rather than imputed. Imputing these variables would introduce artificial 
#and potentially misleading values, as they represent crucial outcomes and key variables: 
#ratings, votes, runtime. Given the large size of the IMDb dataset, excluding these 
#incomplete films does not pose a problem and still leaves a sufficiently representative sample.
eligible_data <- eligible_data %>%
  filter(!is.na(averageRating),
         !is.na(numVotes),
         !is.na(runtimeMinutes))

colSums(is.na(eligible_data))
#Now the eligible dataset is with complete values, inspection can take place

#Check the variable runtimeMinutes
summary(eligible_data$runtimeMinutes)

#Oscars define a feature film has a length that exceeds 40. Additionally, 
#there are some extremely long 'movies' in the dataset that are presumably not
#movies but series compilation. This has to be filtered. IMDb communicated the
#longest movie has a duration of 280 minutes, which is the cutoff point.

eligible_data <- filter(eligible_data,
                 runtimeMinutes >= 40, runtimeMinutes <= 280)

#To ensure reliable analysis, low number of votes should be eliminated as these
#do not result in reliable averageRatings
summary(eligible_data$numVotes)
#The min, 1st quartile and median are both very low. 

#Creating the FINAL dataset named "movies" for further analysis
movies <- filter(eligible_data,
                 numVotes >= 1000)

#Feature engineering
#Dummy for release year 2010 since that is part of the focus of the research
movies$before_2010_dummy <- ifelse(movies$startYear <= 2010, 1, 0)
movies$before_2010_dummy <- factor(movies$before_2010_dummy, levels = c(0, 1), labels = c("Release before 2010", "Release after 2010"))
table(movies$before_2010_dummy)

#Dummy for animation since that is part of the focus of the research
movies$animation_dummy <- ifelse(grepl("Animation", movies$genres), 1, 0)
movies$animation_dummy <- factor(movies$animation_dummy, levels = c(0, 1), labels = c("Non-Animation", "Animation"))
table(movies$animation_dummy)

#Save the definitive dataset as a file
write.csv(
  movies,
  file = "data/movies.csv",   #relative path into the data folder
  row.names = FALSE
)
