#Script dedicated to feature engineering

#Load the package
library(tidyverse)

#Read in data
movies_filtered <- read_csv("gen/temp/movies_filtered.csv")

movies <- movies_filtered

#Dummy for release year 2010 since that is part of the focus of the research
movies$before_2010_dummy <- ifelse(movies$startYear <= 2010, 1, 0)
movies$before_2010_dummy <- factor(movies$before_2010_dummy, levels = c(0, 1), labels = c("Release since 2010", "Release before 2010"))
table(movies$before_2010_dummy)

#Dummy for animation since that is part of the focus of the research
movies$animation_dummy <- ifelse(grepl("Animation", movies$genres), 1, 0)
movies$animation_dummy <- factor(movies$animation_dummy, levels = c(0, 1), labels = c("Non-Animation", "Animation"))
table(movies$animation_dummy)

#Create folder where the documents will be stored locally
dir.create("gen/output", recursive = TRUE)

#Save the definitive dataset as a file
write.csv(movies, file = "gen/output/movies.csv")
