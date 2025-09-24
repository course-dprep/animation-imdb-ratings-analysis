# --- 5) Multicollinearity (if multiple predictors) ---
vifs <- tryCatch(vif(model), error = function(e) NA)
if (!all(is.na(vifs))) {
  cat("VIFs (rule of thumb: < 5 OK, < 10 often acceptable):\n")
  print(vifs); cat("\n")
} else {
  cat("VIFs not available (e.g., single predictor or aliasing).\n\n")
}
}