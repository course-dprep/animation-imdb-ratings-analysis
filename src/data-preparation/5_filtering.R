#Script to filter the dataset

#Load the package
library(tidyverse)

#Read in data
movies_imputed <- read_csv("../../gen/temp/movies_imputed.csv")

#Now the imputed dataset is there, a selection can be made from the consideration
#of the focus of the study

#First check the structure of the dataset
summary(movies_imputed)

#1 - startYear
#The study is interested from the period since the first computer animation 
#released. Therefore, 1995 is taken as the starting point given the release of
#Toy Story. Movies should have been released to ensure consistency across data,
#whereby 2025 is set as the other end for the filter.

movies_filtered <- filter(movies_imputed, startYear >= 1995, 
                                          startYear <= 2025)

#2 - runtimeMinutes
#Oscars define a feature film has a length that exceeds 40. Additionally, 
#there are some extremely long 'movies' in the dataset that are presumably not
#movies but series compilation. This has to be filtered. IMDb communicated the
#longest movie has a duration of 280 minutes, which is the cutoff point.

movies_filtered <- filter(movies_filtered, runtimeMinutes >= 40, 
                                           runtimeMinutes <= 280)

#3 - averageRatings / numVotes
#To ensure reliable analysis, low number of votes should be eliminated as these
#do not result in reliable averageRatings. 

movies_filtered <- filter(movies_filtered, numVotes >= 1000)

#Save the dataset locally
write.csv(movies_filtered, file = "../../gen/temp/movies_filtered.csv", row.names = FALSE)
