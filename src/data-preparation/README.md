# **Data Preparation Steps**

Below, the six files related to the data preparation are summarised.

---
### **Data source**

#### **1_download_raw_data.R**

For this project, a database provided by IMDb (Internet Movie Database) was used. IMDb 
provides rich databases on movies, series, actors, directors and more related to the 
movie industry, and an active group of raters. 

Two public [IMDb-datasets](https://developer.imdb.com/non-commercial-datasets/ "Non-Commercial IMDb-datasets")
were retrieved: *title.basics.tsv.gz* and *title.ratings.tsv.gz*. Title.basics provides information 
about the name, release year, duration, and genre(s) of the movies. Title.ratings contains 
the ratings per title based on the IMDb-users, which is summarised in the average rating and the number of votes.
As for the data structure, the unit of analysis in the data sets, is one movie per row. 
Neither dataset holds temporal information based on for example date.

Initially, the basics dataset provides data on several mediums besides movies, such as series, tv movies,
specials, shorts, etc. From a technological consideration to not overload older devices, this 
raw dataset was specified to movies before saving it to Google Drive. After the data was read-in 
using this script, a local data folder was created to store the files, which were saved as 
CSV-format to facilitate subsequent data preparation.

---

#### **2_merge_raw_data.R**

In this step, the two raw datasets: **raw_basics** and **raw_ratings** were merged into 
a single dataset; **raw_combined**. The merge was performed using the variable `tconst`, 
which serves as the join key and unique identifier for each movie in both datasets. 
This merged dataset was the basis for the remainder of the data preparation.

Initially, the file **raw_basics** consists of 724.580 observations, while the **raw_ratings** 
consists of 1.609.173 observations. Note that this difference is explainable through the 
pre-selection on movies for the basics dataset. The **raw_combined** consists of 724.580 movies
after the left-join of the datasets

---

#### **3_select_variables.R**

First, it was verified if the dataset contains only movies, which is consistent 
with the focus of the study. Subsequently, the variables that are directly relevant for 
the research were selected: `tconst`, `primaryTitle`, `startYear`, `runtimeMinutes`, `genres`, 
`averageRating`, `numVotes`. To ensure proper data handling, the variables `startYear` 
and `runtimeMinutes` were converted from character to numeric format.

Initially, the file **raw_basics** consists of 9 variables and 724580 observations, 
while the **raw_ratings** consists of 3 variables and 1609173 observations. These variables
are summarised in the table below.




---

#### **4_handling_missing_values.R**

Of the movies in this data set, 334.916, have a rating record and 389.664 have missing rating fields, 
which is logical with a left join.


The inspection of the dataset revealed  missing values ("na"") in `startYear`, `runtimeMinutes`,
`averageRating` and `numVotes`. These missing values were imputed through an accurate 
predictive imputation method using the *mice* package. This method is proven to be suitable for 
the prediction of continuous variables based on all other variables in the dataset. This
avoided bias in that these movies were thus not disregarded from further analysis. 
However, upon visual inspection it was revealed the `genres` variable also contained
missing data, which were not automatically detected as "na". Since the *mice* procedure 
works most reliable for continuous variables (numeric), the `genres` variable contained
text and would thus cause problems. Therefore, movies with missing values here were 
removed before the *mice* procedure was performed.

---

#### **5_filtering.R**

After imputation, the dataset was further refined to align with the focus of the 
research. Three filtering steps were applied;

1. First, for `startYear`, only movies released between 1995 and 2025 were retained. 
The starting point of 1995 was chosen to coincide with the release of Toy Story, 
which was the first fully computer-animated feature film. The upper bound of 2025 
was set to ensure movies have had a worldwide released and thus gathered an 
average rating. 

2. Second, there was a filte for `runtimeMinutes`. According to the Academy Awards' 
definition of a feature film, movies should have a runtime of at least 40 minutes. 
For the upper bound, extremely long entries were excluded by setting a limit of 
280 minutes, which is consistent with the longest registered feature film on the 
[IMDb-website](https://www.imdb.com/list/ls049202584/ "Longest Cinematic Films").

3. Third, for `numVotes`, movies with fewer than 1,000 votes were disregarded from
analysis, as low voting numbers are problematic in biasing the average ratings, which
do not provide a generalisable and stable result in comparison to movies with more than
1,000 votes.

---

#### **6_feature_engineering.R**

For the analysis, dummy variables were created. From the variable `startYear`, a 
dummy was constructed that distinguishes between movies *released before 2010* and 
those *released since 2010*. Also, a dummy variable was created for animation based
on the `genres` variable, classifying a movie as *Animation* or *Non-Animation*.
This step finalised the data preperation and resulted in the CSV-file **movies_prepped**.