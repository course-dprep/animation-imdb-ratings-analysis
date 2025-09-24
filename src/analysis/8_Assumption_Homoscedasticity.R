# --- 3) Homoscedasticity ---
plot(model, which = 3)  # Scale–Location plot
bp <- bptest(model)     # Breusch–Pagan
cat("Breusch–Pagan p-value:", bp$p.value, "(p > .05 ≈ equal variance)\n\n")