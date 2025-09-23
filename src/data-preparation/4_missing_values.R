#Script to handle missing values

#Load the packages
library(mice)

#Read in data
movies_selected <- read_csv("temp/data/movies_selected.csv")

#Check whether there are missing values in the dataset
colSums(is.na(movies_selected))

#There are missing values at three values; startYear, runtimeMinutes, averageRating and numVotes.
#These missing values can be imputed through an accurate predicitve imputation method
#through the mice package. 

# Perform multiple imputation
imputed_data <- mice(movies_selected, m = 5, method = 'pmm', seed = 123)

# Get the completed dataset
movies_imputed <- complete(imputed_data)

#Save the file locally
write.csv(movies_imputed, file = "temp/data/movies_imputed.csv", row.names = FALSE)




