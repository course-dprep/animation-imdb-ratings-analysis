#Creating subset of non-animation for further inspection
non_animation_subset <- movies %>% 
  filter(animation_dummy == "Non-Animation")

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