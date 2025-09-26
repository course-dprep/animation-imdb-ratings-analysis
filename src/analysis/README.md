# Analysis

**1_Subsetting.R**

The dataset obtained in the final step of data preparation is used for the analysis. Using the summary and table functions provides an overview of the movie dataset, including the number of animated versus non-animated films. The dataset is then divided into several subsets: animated, non-animated, films released before 2010, and films released since 2010. These subsets are used for further analysis, with an overview showing the number of observations, as well as the range and standard deviation for key variables in each subset.

**2_Exploratory_Visualizations.R**

The following two blocks of code create two histograms: one shows the distribution of average IMDb ratings, and the other shows the number of movies released per year. In both animation and non-animation movies are distinguished by color. Next, the ratio of the non-animated to animated movies in the dataset is calculated. Hereafter, the average IMDb rating is calculated per release year across all movies. This trend is then visualized in a line chart, showing how the average rating develops over time. Then, the same analysis is performed but split by movie types. This code results in a line chart, which compares the development of average ratings for animated and non-animated movies separately, with the y-axis fixed between 0 and 10 to match the IMDb rating scale. Finally, two visualizations are created. First, a smoothed line chart that highlights long-term rating trends over time for both animated and non-animated movies. Second, a boxplot that shows the distribution of movie runtimes in minutes, comparing the spread and median values between the two categories.

**3_Regression_Analysis.R**

First, a t-test is conducted to examine whether animated and non-animated films differ significantly in their average IMDb ratings, which is the case. Next, linear regressions are used to investigate the effect of film type (animation vs. non-animation) and release year on ratings, both without and with control variables (runtime and number of votes). Additionally, another regression analysis is done, looking at the difference in the effect of film type before and after 2010 is analysed using a dummy variable for the release year.

**assumption_check_raw.R**
