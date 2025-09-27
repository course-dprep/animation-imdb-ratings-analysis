#Script to produce first descriptive statistics of the data

#Load the package
library(tidyverse)

#Loading definite dataset
movies <- read_csv("../../gen/temp/movies_prepped.csv")

#Inspecting definitive dataset
summary(movies)
table(movies$animation_dummy)

#Creating subset of animation for further inspection
animation_subset <- movies %>% 
  filter(animation_dummy == "Animation")

#Creating subset of non-animation for further inspection
non_animation_subset <- movies %>% 
  filter(animation_dummy == "Non-Animation")

#Creating subset of before-2010 for further inspection
before_2010_subset <- movies %>% 
  filter(before_2010_dummy == "Release before 2010")

#Creating subset of since-2010 for further inspection
since_2010_subset <- movies %>% 
  filter(before_2010_dummy == "Release since 2010")

#Creating a function for efficiency
inspect_data <- function(df) {
  cat("Generating descriptive statistics...\n\n")
  cat("\n\n")
  
  cat('Summary statistics\n')
  print(summary(df))
  cat('\n\n')
  
  cat('Number of observations in subset: ')
  cat(nrow(df))
  cat('\n\n')
  
  cat('Range in runtime:\n')
  print(max(df$runtimeMinutes) - min(df$runtimeMinutes))
  cat('\n\n')
  
  cat('Standard deviation of runtime:\n')
  print(sd(df$runtimeMinutes))
  cat('\n\n')
  
  cat('Range in average rating:\n')
  print(max(df$averageRating) - min(df$averageRating))
  cat('\n\n')
  
  cat('Standard deviation of average rating:\n')
  print(sd(df$averageRating))
  cat('\n\n')
  
  cat('Range in number of votes:\n')
  print(max(df$numVotes) - min(df$numVotes))
  cat('\n\n')
  
  cat('Standard deviation of number of votes:\n')
  print(sd(df$numVotes))
  cat('\n\n')
  
}

#Above can now be used to check both subsets, With this function any subsets that may be added or needed can easily be added to this script
subsets <- list(
  Animation     = animation_subset,
  NonAnimation  = non_animation_subset,
  Before2010    = before_2010_subset,
  Since2010     = since_2010_subset
)

for (nm in names(subsets)) {
  cat("=== Subset:", nm, "===\n")
  inspect_data(subsets[[nm]])
}

#Saving subsets in output folder
write_csv(animation_subset,   "../../gen/output/animation_subset.csv")
write_csv(non_animation_subset,"../../gen/output/non_animation_subset.csv")
write_csv(before_2010_subset, "../../gen/output/before_2010_subset.csv")
write_csv(since_2010_subset,  "../../gen/output/since_2010_subset.csv")

