#Script to download the raw data files from IMDb

#Load the package
library(googledrive)
#Note, message in console might ask for verification first before you are able to
#load-in the datasets via Google Drive. Prevent this with
drive_deauth()

#Import the IMDb 'basics' file
raw_basics <- read.csv("https://drive.google.com/uc?export=download&id=1kibqUiY63nTgU40dYh3WYGYMnU3HpGpv")

#Import the IMDb 'ratings' file
raw_ratings <- read.csv("https://drive.google.com/uc?export=download&id=1tvvAQKNL6OTTiHc9xwzxkydWupzKMXJs")

#Create folder where the documents will be stored locally
dir.create("temp/data", recursive = TRUE)

#Save the raw datasets locally
write.csv(raw_basics, file = "temp/data/raw_basics.csv", row.names = FALSE)
write.csv(raw_ratings, file = "temp/data/raw_ratings.csv", row.names = FALSE)
