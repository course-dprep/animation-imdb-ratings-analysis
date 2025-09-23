#Script to handle missing values

#Load the packages
library(tidyverse)
library(mice)

#Read in data
movies_selected <- read_csv("temp/data/movies_selected.csv")

#Check whether there are missing values in the dataset
colSums(is.na(movies_selected))

#There are missing values at three values; startYear, runtimeMinutes, averageRating and numVotes.
#These missing values can be imputed through an accurate predictive imputation method
#through the mice package. 

#Perform multiple imputation
imputed_data <- mice(movies_selected, m = 5, method = 'pmm', seed = 123)
movies_imputed <- complete(imputed_data)

#Visual inspection reveals there are missing values in genres, noted as \\N
#Since this variable is not included in analysis but used for dummy coding
#(see script feature engineering), it is left as it is.

#Save the file locally
write.csv(movies_imputed, file = "temp/data/movies_imputed.csv", row.names = FALSE)




