#Script to handle missing values

#Load the packages
library(tidyverse)
library(dplyr)
library(mice)

#Read in data
movies_selected <- read_csv("gen/temp/movies_selected.csv")

#Check whether there are missing values in the dataset
colSums(is.na(movies_selected))

#However, visual inspection of the genres show there are missing values, which are
#noted as \\N instead of na
print(sort(table(movies_selected$genres), decreasing = TRUE), max = 25)

#Movies with \\N are recoded to represent na's
movies_selected <- movies_selected %>%
  mutate(genres = na_if(genres, "\\N"))

#Check whether there are missing values in the updated dataset
colSums(is.na(movies_selected))
#There are missing values at; startYear, runtimeMinutes, genres, averageRating and numVotes.

#The mice package can be used to impute missing values with an accurate predictive imputation
#method. However, since that primarily applies to continuous variables, this poses a problem
#for the genres variable. Therefore, the movies with a missing value for genres are removed.
#This is because mice uses the information from the remained columns to predict the missing
#values for the other continuous variables, which thus results in less biased results.

#The na's of genres are removed with
movies_selected <- movies_selected[!is.na(movies_selected$genres), ]

#Perform multiple imputation
imputed_data <- mice(movies_selected, m = 5, method = 'pmm', seed = 123)
movies_imputed <- complete(imputed_data)

#There are no missing values anymore
colSums(is.na(movies_imputed))

#Save the file locally
write.csv(movies_imputed, file = "gen/temp/movies_imputed.csv", row.names = FALSE)
