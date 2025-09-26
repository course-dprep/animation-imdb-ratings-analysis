# Steps in data preparation

**1_download_raw_data.R**

The raw data were downloaded from a Google Drive link. To ensure a manageable dataset with relevant information, the data only focuses on movies, excluding titles like series, short movies and videos. Two public IMDb files were retrieved: basics and rating. A local data folder was created to store the files, which were saved as CSC format to facilitate subsequent analysis.

**2_merge_raw_data.R**

In this step, the two raw datasets: raw_basics and raw_ratings are merged into a single dataset. The merge is performed using the variable tconst, which serves as a unique identifier for each title and is present in both datasets.

**3_select_variables.R**

First, it is verified if the dataset contains only movies, which is consistent with the focus of the study. Then the variables that are directly relevant for the research are selected: tconst, primaryTitle, startYear, runtimeMinutes, genres, averageRating, numVotes.To ensure proper data handling, the variables startYear and runtimeMinutes were converted from character to numeric format.

**4_missing_values.R**

The inspection of the dataset revealed missing values in startYear, runtimeMinutes, averageRating and numVotes. These missing values can be imputed through an accurate predictive imputation method.This is done to maintain data quality and avoid bias in the subsequent analysis. The genre variable also contains missing data, but this variable is categorical rather than numeric, it contains text labels, genres. This makes it too complex to accurately predict and impute missing values. Therefore, instead of imputing, the missing values in this variable are removed.  

**5_filtering.R**

After imputation, the dataset was further refined to align with the focus of the research. 3 filtering steps were applied. First, startYear, only movies released between 1995 and 2025 were retained. The starting point of 1995 was chosen to coincide with the release of Toy Story, which was the first fully computer-animated feature film, representing a benchmark for the study. The upper bound of 2025 was set to ensure temporal consistency across the data. Second, there was filtered for runtimeMinutes, according to the Academy Awards' definition of a feature film, movies should have a runtime of at least 40 minutes. For the upper bound, extremely long entries were excluded by setting a limit of 280 minutes, which is consistent with IMDb's documentation of the longest registered feature film. Third, averageRatings / numVotes, to ensure reliable average ratings, movies with fewer than 1,000 votes were removed, as low voting numbers do not provide a table basis for evaluation.

**6_feature_engineering.R**

For the analysis, dummy variables were created. From the variable startYear, a dummy was constructed that distinguishes between movies released before 2010 and those released since 2010. Also, a dummy variable was created for animation, indicating whether a movie is classified as animated or not.
