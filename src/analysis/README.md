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


```

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

---

### **5_regression_analysis.R**

---

### **6_post_assumption_check.R**
