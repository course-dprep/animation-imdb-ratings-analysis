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
raw dataset was narrowed down to solely movies before saving it to Google Drive. Upon the data being read-in 
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

The table below displays the initial variables found in the **raw_combined** dataset.

| Column Name       | Description                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| `tconst`          | Unique identifier for each title                                            |
| `titleType`       | Type of medium, such as movie, TV movie, series, short, or special          |
| `primaryTitle`    | Title of the content in its original language                               |
| `originalTitle`   | Title of the content in international language, if applicable               |
| `isAdult`         | Dummy-coded variable indicating whether the content is for adults (0/1)     |
| `startYear`       | Release year of the medium                                                  |
| `endYear`         | End year of the medium; relevant for series and often contains NA values    |
| `runtimeMinutes`  | Duration of the movie in minutes                                            |
| `genres`          | Comma-separated list of genres; supports multiple genres per movie          |
| `averageRating`   | Average rating on a scale from 1 to 10                                      |
| `numVotes`        | Number of votes contributing to the average rating                          |

First, it was verified if the dataset contains only movies using the `titleType` variable.
Subsequently, the variables that were irrelevant to the focus of the research were removed, which
included `originalTitle`, `isAdult` and `endYear`.

As for the data types, the variables that were kept as a character variable were `tconst`, `titleType`, 
`primaryTitle` and `genres`. Numeric fields, like `startYear` and `runtimeMinutes` were converted from 
a character to a numeric variable. `numVotes` remained an an integer count, while `averageRating` 
remained a numeric variable on a scale of 1.0-10.0.

The file was stored as **movies_selected** for further data preparation.

---

#### **4_handling_missing_values.R**

Due to the `tconst` variable serving as the join key, the issue of duplicated values did not occur.
However, the inspection of the dataset revealed  missing values ("na") in `startYear`, `runtimeMinutes`,
`averageRating` and `numVotes`. Most notably, the merging of the **raw_ratings** to the **raw_basics**
file introduced 389.664 missing fields for the `averageRating` and `numVotes`, which is about
half of the total 724580 observations.

These missing values were imputed through an accurate 
predictive imputation method using the *mice* package. This method is proven to be suitable for 
the prediction of continuous variables based on all other variables in the dataset. This
avoided bias in that these movies were thus not disregarded from further analysis. 
However, upon visual inspection it was revealed the `genres` variable also contained
missing data, which were not automatically detected as "na". Since the *mice* procedure 
works most reliable for continuous variables (numeric), the `genres` variable contained
text and would thus cause problems. Therefore, movies with missing values for `genres` were 
removed before the *mice* procedure was performed. Note that the choice was made to
impute these values *before* filtering took place, so bias would not be introduced this way.
Results of this step were stored in **movies_imputed**.

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

The results of this step were temporarily saved as **movies_filtered**.

---

#### **6_feature_engineering.R**

For the analysis, dummy variables were created. From the variable `startYear`, a 
dummy was constructed that distinguishes between movies *released before 2010* (= 1) and 
those *released since 2010* (= 0). Also, a dummy variable was created for animation based
on the `genres` variable, classifying a movie as *Animation* (= 1) or *Non-Animation* (= 0).
This step finalised the data preperation and resulted in the CSV-file **movies_prepped**.