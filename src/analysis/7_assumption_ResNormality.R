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