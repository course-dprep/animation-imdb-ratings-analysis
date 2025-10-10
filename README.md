# About Time: Investigating IMDb Movie Ratings with Release Year and the Effect of Animation

## Research Motivation
Movies -a form of entertainment that has been around for centuries. Although research 
has been performed on movie ratings over time (e.g. Moon et al., 2010; Ramos et  al., 2015), 
the effect of *streaming services* on ratings remains rather unexplored. This is especially notable 
since the world-wide adoption of streaming services caused shifts in the distribution and 
quality perception of movies by audiences (Hennig-Hurau et al., 2021; Kumar, 2023). 
The present study aims to provide academic relevance by filling this gap. Movie-watchers nowadays have a 
broader reference frame and thus become more critical in evaluating content (Hadida et al., 2020). 
In addition, streaming has resulted in a higher output of movies, which results in a saturated
market to choose from. Resultingly, a negative relationship is hypothesised between release year 
and the average rating.

However, this effect is hypothesised to differ between animation and non-animation movies. 
As such, technological innovations over time have enhanced the storytelling opportunities 
and visual possibilities of this genre (Sun, 2023). Current research has not specifically 
compared animation versus non-animation, whereby the present study aims to shed further light on 
on the moderating role of genre on the relationship between release year and the average rating.

Besides the academic relevance, the insights are also socially relevant for filmmakers and 
distributors to better understand audiences’ opinion. All in all, focus of the research can 
be encapsulated with the following research question:

### Research Question

*To what extent does the release year of a movie influence its average IMDb rating, 
and does this relationship differ between animated and non-animated films?*

## Data

In order to test H1 and H2 and therefore answer the main research question,
secondary data is consulted from [IMDb.com](https://developer.imdb.com/non-commercial-datasets/).
The database holds several datasets, of which two provide relevance in the context
of the present study:

>[title.basics.tsv.gz](https://datasets.imdbws.com/title.basics.tsv.gz): information
>about the title, runtime, genres and release year.

>[title.rating.tsv.gz](https://datasets.imdbws.com/title.ratings.tsv.gz): information 
>on ratings derived from IMDb users.

The dataset merged from the secondary data contains the following variables:
 
| Variable            | Type      | Definition                                                              |
|---------------------|-----------|-------------------------------------------------------------------------|
| `tconst`            | character | Unique IMDb identifier for each title                                   |
| `primaryTitle`      | character | The international title of a movie                                      |
| `startYear`         | integer   | Release year of a movie                                                 |
| `runtimeMinutes`    | integer   | Runtime expressed in minutes                                            |
| `genres`            | character | Genres separated by commas                                              |
| `averageRating`     | numeric   | Average IMDb user rating (0.0–10.0)                                     |
| `numVotes`          | integer   | Number of votes received by the title                                   |
| `before_2010_dummy` | dummy     | Whether a movie is released before or after 2010                        |
| `animation_dummy`   | dummy     | Whether a movie is animated or not                                      |


## Method

Data analysis consisted of three consecutive parts:

1. **Descriptive statistics** were performed on four subsets of the data; 
- Animation movies
- Non-Animation movies
- Movies released before 2010
- Movies released since 2010

2. **Independent t-tests** were performed to uncover significant differences in the 
average ratings between the above mentioned subsets.

3. **Linear regression** models were conducted that predicted the dependent variable of
average IMDb rating. Three models were compiled;
- Model 1 including the two dummy predictors
- Model 2 including the two dummy predictors, control variables
- Model 3 including the two dummy predictors, their interaction, and control variables.

## Preview of Findings

Elaborate details are deployed in two documents:

1. A data exploration PDF-document is generated that provides descriptive statistics and visualisations of the 
prepped data set that was used for analysis.

2. The end product is deployed in the form of a PDF-document, which further elaborates on the motivation, 
literature, methodology, findings and conclusions. 

The graph below can be used to describe the general gist of the findings. There are significant differences in rating, 
with animation movies scoring higher than non-animation movies. Additionally, movies released before 2010 are 
proven to score significantly higher than movies released since 2010. Nevertheless, results show no significant 
results for the interaction between release year and animation status in predicting the average IMDb rating.

![Line graph of average rating over time](https://github.com/user-attachments/assets/959fe1ce-9a5a-4001-9ecd-a2fe626519fe)

The findings yielded provide social relevance in that the success of films are independent of when they are released.
Despite that, the results show the animation genre is appealing to audiences, as expressed with the higher ratings. 

## Repository Overview

The structure of our repository is as follows:

``` text
project-name/
├─ paper/
│  ├─ makefile
│  └─ paper.Rmd
├─ src/
│  ├─ analysis/
│  │  ├─ 10_pre_assumption_check.R
│  │  ├─ 11_regression_analysis.R
│  │  ├─ 12_post_assumption_check.R
│  │  ├─ 9_t-test.R
│  │  ├─ README.md
│  │  └─ makefile
│  ├─ data-exploration/
│  │  ├─ 7_descriptive_statistics.R
│  │  ├─ 8_exploratory_visualisations.R
│  │  ├─ Data_exploration.Rmd
│  │  ├─ README.md
│  │  └─ makefile
│  ├─ data-preparation/
│  │  ├─ 1_download_raw_data.R
│  │  ├─ 2_merge_raw_data.R
│  │  ├─ 3_select_variables.R
│  │  ├─ 4_handling_missing_values.R
│  │  ├─ 5_filtering.R
│  │  ├─ 6_feature_engineering.R
│  │  ├─ README.md
│  │  └─ makefile
│  └─ .gitkeep
├─ .gitignore
├─ README.md
├─ makefile
```

## Dependencies

By using the installation guides as found on [Tilburg University's Science Hub](http://tilburgsciencehub.com/),
ensure your device has the following software installed:

- Make - [installation guide](https://tilburgsciencehub.com/building-blocks/configure-your-computer/automation-and-workflows/make/).
- R / R Studio - [installation guide](https://tilburgsciencehub.com/building-blocks/configure-your-computer/statistics-and-computation/r/).

Within R Studio, ensure the following packages are installed.

``` r
# Install the following packages
install.packages("googledrive")
install.packages("tidyverse")
install.packages("mice")
install.packages("car")
install.packages("lmtest")
install.packages("broom")
install.packages("here")
install.packages("lm.beta")
```

## Running Instructions

Replicating the workflow of this study can be achieved by taking the following steps:

1. Fork the repository using GitHub

2. Open your preferred terminal/command line (e.g., Git GUI)

3. Create a copy of this repository to your local machine by copying the following sentence in your preferred terminal/command line:
```
git clone https://github.com/course-dprep/animation-imdb-ratings-analysis.git
```

4. Set your working directory to the just forked repository `animation-ADD NAME` and run the following word in your preferred terminal/command line:
```
make
``` 

5. Afterwards, you can clean the working directory if desired by removing the gen and data folder by running the following in your preferred terminal/command line:
```
make clean
``` 

## About

This project is set up as part of the course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) of the [Master of Science
Marketing Analytics](https://www.tilburguniversity.edu/education/masters-programs/marketing-analytics/program) program 
at [Tilburg University](https://www.tilburguniversity.edu/), based in The Netherlands. The project is implemented by: 
- Britt van Haaster 
- Isah Huijbregts 
- Lars van der Kroft 
- Amanda van Lankveld 
- Amy Quist
- Stefan Valentijn

## References

Hadida, A. L., Lampel, J., Walls, W. D., & Joshi, A. (2020). Hollywood
Studio Filmmaking in the Age of Netflix: a Tale of Two Institutional
Logics. Journal of Cultural Economics, 45(2), 213–238. <https://doi.org/10.1007/s10824-020-09379-z>

Hennig-Thurau, T., Ravid, S. A., & Sorenson, O. (2021). The Economics of
Filmed Entertainment in the Digital Era. Journal of Cultural Economics,
45(2), 157–170. <https://doi.org/10.1007/s10824-021-09407-6>

Kumar, L. (2023, April). A Study On The Impact Of The OTT Platform On
The Cinema With The Special Reference On The Cinema Audience.
ResearchGate; unknown. <https://www.researchgate.net/publication/376650380_A_Study_On_The_Impact_Of_The_OTT_Platform_On_The_Cinema_With_The_Special_Reference_On_The_Cinema_Audience>

Moon, S., Bergey, P. K., & Iacobucci, D. (2009). Dynamic Effects among
Movie Ratings, Movie Revenues, and Viewer Satisfaction. Journal Of
Marketing, 74(1), 108–121. <https://doi.org/10.1509/jmkg.74.1.108>

Ramos, M., Calvão, A. M., & Anteneodo, C. (2015). Statistical patterns in movie rating behavior. PLOS ONE, 10(8), e0136083. https://doi.org/10.1371/journal.pone.0136083>

Sun, Z. (2023). What does cgi digital technology bring to the
sustainable development of animated films?. Sustainability, 15(14),
10895.<https://doi.org/10.3390/su151410895>
