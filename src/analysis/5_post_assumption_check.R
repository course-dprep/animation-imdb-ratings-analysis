#Script to check the assumptions of the regression model

#load the packages
library(tidyverse)
library(car)
library(broom)

#Checking post-assumptions of a linear regression model is specificied to its residuals,
#and includes; normality, linearity, homoscedasticity and independence of errors

#Below, a function is made to check a regression version
check_assumptions <- function(REGRESSION_VERSION) {
  cat("The command you just ran will check the post-assumptions of your specified linear regression model\n")
  
  cat("\n1) Normality of residuals: Shapiro-Wilk, Kolmogorov-Smirnov, Histogram\n")
  cat("\n1.1) Shapiro-Wilk test\n")
  sampled_residuals <- sample(REGRESSION_VERSION$residuals, 5000)  #the test can handle max 5000 data-points
  shapiro_test <- shapiro.test(sampled_residuals); print(shapiro_test)
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
  if (smirnov_test$p.value <= 0.05) {
    print("Assumption is violated; Kolmogorov-Smirnov test is significant")
  } else {
    print("Assumption is met; Kolmogorov-Smirnov test is NOT significant")
  }
  
  cat("\n=======================================================================================\n")
  
  cat("\n1.3) Histogram\n\n")
  model_residuals <- data.frame(.resid = residuals(version2))
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
  ggsave("../../gen/output/assumptions_histogram.png", plot = create_histogram)
  print("Output requires visual inspection to assess if assumption is violated")
  print("Please consult 'assumption_histogram.png' in the gen/output folder")

  cat("\n=======================================================================================\n")
  
  cat("\n2) Linearity and Homoscedasticity: ZPRED vs ZRESID plot\n\n")
  png("../../gen/output/assumptions_ZPRED_vs_ZRESID_plot.png")
  plot(version2, which=1)
  dev.off()
  print("Output requires visual inspection to assess if assumption is violated")
  print("Please consult 'assumptions_ZPRED_vs_ZRESID_plot.png' in the gen/output folder")
  
  cat("\n=======================================================================================\n")
  
  cat("\n3) Multicollinearity: Variance Inflation Factor (VIF)\n")
  vif_test <- vif(REGRESSION_VERSION, type = "predictor"); print(vif_test)
  cat("\n")
  mean_adjusted_vif <- mean(vif_test[, "GVIF^(1/(2*Df))"])
  if (mean_adjusted_vif > 1 & mean_adjusted_vif < 5) {
    print("Assumption is met; average VIF is NOT substantially greater than 1")
  } else {
    print("Assumption is violated; average VIF is substantially greater than 1")
  }
  
  cat("\n=======================================================================================\n")
  
  cat("\n4) Independence of residuals: Durbin–Watson test\n")
  durbin_watson <- lmtest::dwtest(REGRESSION_VERSION); print(durbin_watson)
  dw_stat <- durbin_watson$statistic["DW"]
  if (dw_stat > 1 & dw_stat < 3) {
    print("Assumption is met; Durbin-Watson value is close to 2")
  } else {
    print("Assumption is violated; Durbin-Watson value is below 1 or above 3")
  }
  
}

#The function has been created, and applied to the linear regression versions
check_assumptions(version2)
