# **Analysis Information**

Below, the six files related to the analysis are elaborated on.

---

### **1_descriptive_statistics.R**

The dataset obtained in the final step of data preparation is used for the analysis. 
Using the summary and table functions provides an overview of the movie dataset, 
including the number of animated versus non-animated films. The dataset is then 
divided into several subsets: animated, non-animated, films released before 2010, 
and films released since 2010. These subsets are used for further analysis, with 
an overview showing the number of observations, as well as the range and standard 
deviation for key variables in each subset.



The runtime of films looks similar for the different subsets, ranging between 90 and 100 minutes. 
When it comes to average ratings, animated titles tend to score slightly higher on average, with 
a mean of 6.5 compared to 6.2 for other genres. For startyear the average ratings look similar. 
The animated movies are underrepresented in the subset. And it can be seen that since 2010 many 
more movies are available but the movies are rated less times per movie.

| Subset | Observations | Mean runtime minutes | Mean averageratings | Mean number of votes | SD averageratings |
|------------|------------|------------|------------|------------|------------|
| Animation | 1,846 | 90.5 | 6.51 | 43,393 | 1.08 |
| Non-Animation | 64,051 | 96.8 | 6.22 | 30,608 | 1.17 |
| Before 2010 | 20,537 | 97.0 | 6.29 | 35,085 | 1.14 |
| Since 2010 | 45,360 | 96.4 | 6.20 | 29,101 | 1.18 |



---

### **2_exploratory_visualisations.R**

The following two blocks of code create two histograms: one shows the distribution 
of average IMDb ratings, and the other shows the number of movies released per year. 
In both animation and non-animation movies are distinguished by color. Next, the ratio 
of the non-animated to animated movies in the dataset is calculated. Hereafter, 
the average IMDb rating is calculated per release year across all movies. This 
trend is then visualized in a line chart, showing how the average rating develops 
over time. Then, the same analysis is performed but split by movie types. This 
code results in a line chart, which compares the development of average ratings 
for animated and non-animated movies separately, with the y-axis fixed between 0 
and 10 to match the IMDb rating scale. Finally, two visualizations are created. 
First, a smoothed line chart that highlights long-term rating trends over time 
for both animated and non-animated movies. Second, a boxplot that shows the distribution 
of movie runtimes in minutes, comparing the spread and median values between the two categories.


For the visualizations, three plots were selected that provided a good clear overview of relevant 
information about movies and movie types.

![Line plot of average rating per year per type](../../gen/output/line_avg_rating_by_type.png)


![Smooth plot, average rating per year per type](../../gen/output/smooth_avg_rating_by_type.png)


![Box plot, average rating per year per type](../../gen/output/boxplot_runtime.png)


In the first plot the average rating over time for animated and non-animated movies can be seen. 
It can be seen that the ratings are close but animated movies are typically rated somewhat higher 
than non-animated movies.

In the second plot it can be seen that the average rating for animated movies is declining over 
time and the rating of non-animated movies is not stable but in the last years the rating is increasing. 

In the last plot the distribution for runtime can be seen. It can be seen that for both genres 
the average runtime is similar and around 90/100 minutes. For both genres there are some outliers 
which are longer than 200 minutes, or under 50 minutes.



---

### **3_t-test.R**

First, a t-test is conducted to examine whether animated and non-animated films 
differ significantly in their average IMDb ratings, which is the case. Next, 
linear regressions are used to investigate the effect of film type (animation vs. non-animation) 
and release year on ratings, both without and with control variables (runtime and number of votes). 
Additionally, another regression analysis is done, looking at the difference in 
the effect of film type before and after 2010 is analysed using a dummy variable 
for the release year.

---

### **4_pre_assumption_check.R**

Before running the regression analyses, several preliminary checks were performed to verify key model assumptions.
The prepared dataset (movies_prepped.csv) contains 65,897 observations and 9 variables, including both numerical
(startYear, runtimeMinutes, averageRating, numVotes) and categorical features.

As part of the pre-assumption checks, the linearity between each numerical predictor (numVotes, runtimeMinutes, startYear)
and the dependent variable (averageRating) was visually assessed. Scatterplots with LOESS smoothers were generated to evaluate
whether a linear relationship could be reasonably assumed. These plots serve as a diagnostic step to confirm that the data
meet the linearity assumption required for subsequent regression analyses.
---

### **5_regression_analysis.R**
Three linear regression models were estimated to examine how animation status and release period relate to IMDb ratings.
Categorical dummy variables were created for animation type and whether a movie was released before or after 2010.
In addition, log-transformed versions of numVotes and runtimeMinutes were included as control variables to reduce skewness.

Model 1 included only the two dummy variables and showed that both being released since 2010 and being non-animated
were associated with slightly lower average ratings. Although statistically significant, the model explained very little variance (R² ≈ 0.003).

Model 2 added control variables for startYear, log_runtimeMinutes, and log_numVotes. The model fit improved
(R² ≈ 0.06). The number of votes and runtime showed positive associations with ratings, while the main effects of release
period and animation type remained negative and significant.

Model 3 included interaction terms to test whether the effect of animation type differed across release periods or
over time. These interaction effects were not significant, and the model fit did not improve further.

Overall, the analyses suggest that animated movies tend to receive slightly higher ratings than non-animated ones,
but more recent movies (since 2010) tend to be rated slightly lower. Films with longer runtimes and higher numbers
of votes are generally rated more positively.
---

### **6_post_assumption_check.R**

After estimating the regression models, a comprehensive post-assumption check was performed to ensure that the main assumptions of linear regression were met.
For each model, residual diagnostics were conducted to assess normality, linearity, homoscedasticity, multicollinearity, and independence of residuals.

Normality of residuals was tested using the Shapiro–Wilk and Kolmogorov–Smirnov tests, both of which were significant across all models, indicating mild deviations from perfect normality.
However, with a large sample size (n ≈ 65,000), such tests are highly sensitive, and visual inspection of the residual histograms suggested that deviations were not severe.

Plots of standardized predicted values versus residuals showed no strong nonlinear patterns, suggesting that the assumptions of linearity and homoscedasticity were broadly acceptable.
The Variance Inflation Factor (VIF) values for all predictors were well below common thresholds, indicating no problematic multicollinearity.
Finally, the Durbin–Watson test yielded values around 2 for all models, suggesting that residuals were independent and not autocorrelated.

Overall, while minor departures from normality were observed (as expected in large datasets), the diagnostic checks indicated that the regression assumptions were sufficiently met for reliable interpretation of the models.
