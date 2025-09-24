# install.packages(c("car", "lmtest", "broom"))

library(car)        # VIF, Durbin–Watson
library(lmtest)     # Breusch–Pagan
library(broom)      # augment() for residual data frame

# install.packages(c("car","lmtest","broom","nortest"))  # if needed
library(car)
library(lmtest)
library(broom)
library(ggplot2)
library(nortest)  

# for ad.test (Anderson–Darling, works for large n)

check_lm_assumptions <- function(model, model_name = deparse(substitute(model))) {
  cat("\n==============================\n")
  cat("Assumption checks for:", model_name, "\n")
  cat("==============================\n\n")
  
  # Residuals (drop NAs)
  res <- residuals(model)
  res <- res[is.finite(res)]
  n <- length(res)
  cat("Number of residuals:", n, "\n\n")