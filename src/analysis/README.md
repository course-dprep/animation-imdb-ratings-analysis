# **Analysis Information**

Below, the four files related to the analysis are elaborated on.

---

### **9_t-test.R**

This script performs an *independent t-test* on whether there is a significant difference in rating between
animation and non-animation movies.

---

### **10_pre_assumption_check.R**

Before running the *regression analyses*, several preliminary checks were performed to verify key model assumptions.
The linearity between each numerical predictor (`numVotes`, `runtimeMinutes`, `startYear`) and the dependent 
variable (`averageRating`) was visually assessed with scatterplots.

---

### **11_regression_analysis.R**

Three linear regression models were estimated to examine the hypotheses. The created dummy variables were entered,
as well as a log transformed version of `numVotes` and `runtimeMinutes` as resulting from the pre-assumption check.

1. *Model 1*: including the basic predictors; `dummy_animation` and `dummy_before_2010`

2. *Model 2*: including the basic predictors and control variables; `dummy_animation`, `dummy_before_2010`, 
`startYear`, `log_runtimeMinutes` and `log_numVotes`.

3. *Model 3*: including the basic predictors and control variables and interactions;`before_2010_dummy`x`animation_dummy`,
`animation_dummy`x`startYear`, and `startYear`, `log_runtimeMinutes` and `log_numVotes`.

---

### **12_post_assumption_check.R**

After estimating the regression models, a comprehensive post-assumption check was performed to ensure that the main assumptions of linear regression were met.
For each model, this script rurns residual diagnostics were conducted on the following assumptions;

- *Normality*: using the Shapiro-Wilk test, the Kolmogorov-Smirnov test and a histogram of residuals
- *Homoscedasticity* and *Linearity*: using a ZPRED vs ZRESID plot
- *Multicollinearity*: using the Variance Inflation Factor
- *Independence*: using the Durbin-Watson test