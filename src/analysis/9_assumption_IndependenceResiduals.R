# --- 4) Independence of residuals ---
dw <- durbinWatsonTest(model)
cat("Durbin–Watson statistic:", unname(dw$dw), "  p-value:", dw$p,
    "  (≈2 is good; <1 or >3 problematic)\n\n")