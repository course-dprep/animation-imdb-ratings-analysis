# Exploring IMDb Dataset

# Loading Packages
library(tidyverse)

#load in data
movies <- read.csv("temp/data/movies_definitive.csv")

dir.create("temp/output", recursive = TRUE, showWarnings = FALSE)

#Inspecting definitive dataset
summary(movies)
table(movies$animation_dummy)
