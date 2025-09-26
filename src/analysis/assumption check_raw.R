################################
# ASSUMPTIONS CHECKS 
################################
# Packages for diagnostics
# install.packages(c("car", "lmtest", "broom"))

library(car)        # VIF, Durbin–Watson
library(lmtest)     # Breusch–Pagan
library(broom)      # augment() for residual data frame

# install.packages(c("car","lmtest","broom","nortest"))  # if needed
library(car)
library(lmtest)
library(broom)
library(ggplot2)
library(nortest)   # for ad.test (Anderson–Darling, works for large n)

check_lm_assumptions <- function(model, model_name = deparse(substitute(model))) {
  cat("\n==============================\n")
  cat("Assumption checks for:", model_name, "\n")
  cat("==============================\n\n")
  
  # Residuals (drop NAs)
  res <- residuals(model)
  res <- res[is.finite(res)]
  n <- length(res)
  cat("Number of residuals:", n, "\n\n")
  
  # --- 1) Linearity & general spec ---
  plot(model, which = 1)  # Residuals vs Fitted (should be random cloud)
  
  # --- 2) Normality of residuals ---
  # Q–Q plot (always useful)
  plot(model, which = 2)
  # Histogram with overlaid normal curve
  res_df <- augment(model)
  ggplot(res_df, aes(.resid)) +
    geom_histogram(aes(y = after_stat(density)), bins = 30) +
    stat_function(
      fun  = dnorm,
      args = list(mean = mean(res, na.rm = TRUE), sd = sd(res, na.rm = TRUE))
    ) +
    labs(title = paste0(model_name, ": Residuals Histogram"),
         x = "Residuals", y = "Density")
  
  # Normality test: choose based on sample size
  if (n >= 3 && n <= 5000) {
    sh <- shapiro.test(res)
    cat("Shapiro–Wilk p-value:", sh$p.value, "(valid for n ≤ 5000)\n\n")
  } else if (n > 5000) {
    ad <- ad.test(res)  # Anderson–Darling (no small-n cap)
    cat("Anderson–Darling p-value:", ad$p.value, "(used because n > 5000)\n",
        "Note: with very large n, tiny deviations look significant—trust the Q–Q plot.\n\n", sep = "")
    # Optional: KS on standardized residuals (commented out by default)
    # ks <- ks.test(scale(res), "pnorm")
    # cat("Kolmogorov–Smirnov p-value:", ks$p.value, "\n\n")
  } else {
    cat("Normality test skipped (need at least 3 residuals). Use Q–Q plot visually.\n\n")
  }
  
  # --- 3) Homoscedasticity ---
  plot(model, which = 3)  # Scale–Location plot
  bp <- bptest(model)     # Breusch–Pagan
  cat("Breusch–Pagan p-value:", bp$p.value, "(p > .05 ≈ equal variance)\n\n")
  
  # --- 4) Independence of residuals ---
  dw <- durbinWatsonTest(model)
  cat("Durbin–Watson statistic:", unname(dw$dw), "  p-value:", dw$p,
      "  (≈2 is good; <1 or >3 problematic)\n\n")
  
  # --- 5) Multicollinearity (if multiple predictors) ---
  vifs <- tryCatch(vif(model), error = function(e) NA)
  if (!all(is.na(vifs))) {
    cat("VIFs (rule of thumb: < 5 OK, < 10 often acceptable):\n")
    print(vifs); cat("\n")
  } else {
    cat("VIFs not available (e.g., single predictor or aliasing).\n\n")
  }
}

# Run checks for your models
check_lm_assumptions(Regression,    "Regression (startYear * animation_dummy)")
check_lm_assumptions(CV_regression, "CV_regression (+ runtimeMinutes + numVotes)")

