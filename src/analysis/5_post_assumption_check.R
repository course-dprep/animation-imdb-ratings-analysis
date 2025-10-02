#Script to check the assumptions of the regression model

#load the packages
library(tidyverse)
library(car)
library(broom)
library(lmtest)

#Read in the regression results
MODEL1_unstandardised <- readRDS("../../gen/output/MODEL1_unstandardised.rds")
MODEL1_unstandardised <- readRDS("../../gen/output/MODEL2_unstandardised.rds")
MODEL1_unstandardised <- readRDS("../../gen/output/MODEL3_unstandardised.rds")

#Checking post-assumptions of a linear regression model is specified to its residuals,
#and includes; normality, linearity, homoscedasticity and independence of errors.
#These are run on the unstandardised models

#Below, a function is made to check a regression version
check_assumptions <- function(REGRESSION_VERSION) {

  cat("The command you just ran will check the post-assumptions of your specified linear regression model\n")
  
  cat("\n1) Normality of residuals: Shapiro-Wilk, Kolmogorov-Smirnov, Histogram\n")
  cat("\n1.1) Shapiro-Wilk test\n")
  sampled_residuals <- sample(REGRESSION_VERSION$residuals, 5000)  #the test can handle max 5000 data-points
  shapiro_test <- shapiro.test(sampled_residuals); print(shapiro_test)
  
  #Automatically print the result of this assumption test
  if (shapiro_test$p.value <= 0.05) {
    print("Assumption is violated; Shapiro-Wilk test is significant")
  } else {
    print("Assumption is met; Shapiro-Wilk test is NOT significant")
  }
  
  
  cat("\n=======================================================================================\n")
  
  
  cat("\n1.2) Kolmogorov-Smirnov test\n")
  smirnov_test <- suppressWarnings(ks.test(REGRESSION_VERSION$residuals, 
          "pnorm", 
          mean=mean(REGRESSION_VERSION$residuals), 
          sd=sd(REGRESSION_VERSION$residuals))); print(smirnov_test)
  
  #Automatically print the result of this assumption test
  if (smirnov_test$p.value <= 0.05) {
    print("Assumption is violated; Kolmogorov-Smirnov test is significant")
  } else {
    print("Assumption is met; Kolmogorov-Smirnov test is NOT significant")
  }
  
  
  cat("\n=======================================================================================\n")
  
  
  cat("\n1.3) Histogram\n\n")
  model_residuals <- data.frame(.resid = residuals(REGRESSION_VERSION))
  create_histogram <- ggplot(model_residuals, aes(.resid)) +
    geom_histogram(aes(y = after_stat(density)),
                   bins = 40,
                   fill = "skyblue", color = "black") +
    stat_function(fun = dnorm, 
                  args = list(mean = mean(model_residuals$.resid), sd = sd(model_residuals$.resid)),
                  color = "red", size = 1) +
    labs(title = "Histogram of Residuals with Normal Curve",
         x = "Residuals", 
         y = "Density"); print(create_histogram)
  
  #To avoid images being overrun, the model name is seperately saved
  model_name <- deparse(substitute(REGRESSION_VERSION))
  filename <- paste0("../../gen/output/assumptions_histogram_", model_name, ".png")
  ggsave(filename, plot = create_histogram)

  #Automatically print the result of this assumption test
  print("Output requires visual inspection to assess if assumption is violated")
  print("Please consult 'assumption_histogram.png' in the gen/output folder")

  
  cat("\n=======================================================================================\n")
  
  
  cat("\n2) Linearity and Homoscedasticity: ZPRED vs ZRESID plot\n\n")
  #To avoid images being overrun, the model name is seperately saved
  model_name <- deparse(substitute(REGRESSION_VERSION))
  zpz_file <- paste0("../../gen/output/assumptions_plot_ZPREDvsZRESID_", model_name, ".png")
  png(zpz_file)
  plot(MODEL1_unstandardised, which=1)
  dev.off()

  #Automatically print the result of this assumption test
  print("Output requires visual inspection to assess if assumption is violated")
  print("Please consult 'assumptions_ZPRED_vs_ZRESID_plot.png' in the gen/output folder")
  
  
  cat("\n=======================================================================================\n")
  
  
  cat("\n3) Multicollinearity: Variance Inflation Factor (VIF)\n")
  vif_test <- vif(REGRESSION_VERSION, type = "predictor")

  #For models with main effects, solely the VIF-values are the output
  if (is.numeric(vif_test)) {
    vif_values <- vif_test
    mean_vif <- mean(vif_values, na.rm = TRUE)
    cat("VIF values:\n")
    print(vif_test)
    
    #For models with interaction effects, a matrix/data frame (GVIF) is the output
  } else {
    vif_values <- vif_test[, "GVIF^(1/(2*Df))"]
    mean_vif <- mean(vif_values, na.rm = TRUE)
    cat("GVIF values:\n")
    print(vif_test)
  }
  
  #Automatically print the result of this assumption test
  if (mean_vif > 1 & mean_vif < 5) {
    print("Assumption is met; average VIF is NOT substantially greater than 1")
  } else {
    print("Assumption is violated; average VIF is substantially greater than 1")
  }
  
  
  cat("\n=======================================================================================\n")
  
  
  cat("\n4) Independence of residuals: Durbin–Watson test\n")
  durbin_watson <- lmtest::dwtest(REGRESSION_VERSION); print(durbin_watson)
  dw_stat <- durbin_watson$statistic["DW"]
  cat("\n")
  
  #Automatically print the result of this assumption test
    if (dw_stat > 1 & dw_stat < 3) {
    print("Assumption is met; Durbin-Watson value is close to 2")
  } else {
    print("Assumption is violated; Durbin-Watson value is below 1 or above 3")
  }
  
  
  cat("\n=======================================================================================\n")
  
  model_name <- deparse(substitute(REGRESSION_VERSION))
  cat("\nThis marks the end of the assumption checking for", model_name, "\n")
  
}


#The above function can be applied to the regression models
check_assumptions(MODEL1_unstandardised)
check_assumptions(MODEL2_unstandardised)
check_assumptions(MODEL3_unstandardised)
