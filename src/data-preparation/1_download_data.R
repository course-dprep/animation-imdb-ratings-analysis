#Script to download the raw data files from IMDb

#Load packages
library(googledrive)
#Note, message in console asks for verification first before you are able to
#load-in the datasets via Google Drive. Prevent this with
drive_deauth()

dir.create('data2')

#Import the IMDb 'basics' file
raw_basics <- read.csv("https://drive.google.com/uc?export=download&id=1kibqUiY63nTgU40dYh3WYGYMnU3HpGpv")

#Import the IMDb 'ratings' file
raw_ratings <- read.csv("https://drive.google.com/uc?export=download&id=1tvvAQKNL6OTTiHc9xwzxkydWupzKMXJs")
