#Script to check the assumptions of the regression model

#load the packages
library(ggplot2)
library(broom)

# assumption checks
check_assumptions <- function(model, model_name = deparse(substitute(model))) {
  # 1) Histogram of residuals with normal curve
  res_df <- augment(model)
  print(
    ggplot(res_df, aes(.resid)) +
      geom_histogram(aes(y = after_stat(density)), binwidth = 5) +
      stat_function(
        fun  = dnorm,
        args = list(mean = mean(res_df$.resid),
                    sd   = sd(res_df$.resid)),
        color = "red", linewidth = 1
      ) +
      labs(title = paste("Residuals histogram with normal curve -", model_name),
           x = "Residuals", y = "Density")
  )
  
  # 2) Residuals vs Fitted plot
  plot(model, which = 1, main = paste("Residuals vs Fitted -", model_name))
  
  #Multicollinearity
  cat("\n[3] Multicollinearity (Variance Inflation Factors)\n")
  print(car::vif(model))
  
  # Independence of residuals (Durbin Whatson test)
  cat("\n[4] Independence of residuals (Durbin–Watson test)\n")
  print(lmtest::dwtest(model))
}

# List of model names to try
model_names <- c(
  "Regression",
  "CV_regression",
  "Regression_Releaseyeardummy",
  "CV_regression_Releaseyeardummy"
)

# Run checks for each model that exists
for (nm in model_names) {
  if (exists(nm)) {
    check_assumptions(get(nm), nm)
  } else {
    message("Model not found (did you run the regression script?): ", nm)
  }
  
  
}