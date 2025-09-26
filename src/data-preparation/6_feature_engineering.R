#Script dedicated to feature engineering

#Load the package
library(tidyverse)

#Read in data
movies_filtered <- read_csv("../../gen/temp/movies_filtered.csv")

#Dummy for release year 2010 since that is part of the focus of the research
movies_filtered$before_2010_dummy <- ifelse(movies_filtered$startYear <= 2010, 1, 0)
movies_filtered$before_2010_dummy <- factor(movies_filtered$before_2010_dummy, levels = c(0, 1), labels = c("Release since 2010", "Release before 2010"))
table(movies_filtered$before_2010_dummy)

#Dummy for animation since that is part of the focus of the research
movies_filtered$animation_dummy <- ifelse(grepl("Animation", movies_filtered$genres), 1, 0)
movies_filtered$animation_dummy <- factor(movies_filtered$animation_dummy, levels = c(0, 1), labels = c("Non-Animation", "Animation"))
table(movies_filtered$animation_dummy)

#Create folder where the documents will be stored locally
dir.create("../../gen/output", recursive = TRUE)

movies_prepped <- movies_filtered

#Save the definitive dataset as a file
write.csv(movies_prepped, file = "../../gen/temp/movies_prepped.csv", row.names = FALSE)
