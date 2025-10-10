# About Time: Analysing IMDb Movie Ratings with Release Year and the Effect of Animation

## Motivation
Movies -a form of entertainment that has been around for centuries. Yet, the 
distribution and consumer perceptions of movies have shifted since the introduction 
of streaming services (Hennig-Hurau et al., 2021; Kumar, 2023). In 2010, the 
international expansion of Netflix across the globe marked a key point in the 
growth of on-demand content (Oberoj, 2024). The saturation and availability of 
the entertainment market have resulted in more critical consumers, which seemingly 
affects how audiences evaluate films (Hadida et al., 2020). Although research 
has been performed on movie ratings over time (e.g. Moon et al., 2010; Ramos et 
al., 2015), the effect of streaming remains rather unexplored.

Over the years, black-and-white deaf movies have advanced to colourful and 
effects-heavy motion pictures due to technological developments. This is 
especially prominent in animation, where disruptions in Computer Generated 
Images (CGI) and production techniques have significantly enhanced visual 
quality and storytelling opportunities (Sun, 2023). Consequently, audience 
evaluations of animated films could differ from live-action films.  Yet, 
current research has not addressed this focus on animation.

All in all, the present study provides academic relevance by investigating the 
temporal dynamics on  the quality perception of movies, while also accounting 
for the effect of animation. These insights are also socially relevant for 
filmmakers and distributors to better understand audiences. The focus of the 
research can be encapsulated with the following research question:

### Research Question

*To what extent does the release year of a movie influence its average IMDb rating,
and does this relationship differ between animated and non-animated films?*

### Hypotheses

Ever since the introduction of Netflix, more streaming services have entered the 
market with players such as Disney+, Amazon Prime Video and HBO Max. Competitiveness 
rose, resulting in a greater variety of TV shows and movies offered (Thompson, 2024). 
Simultaneously, the more experienced a viewer is in watching movies, the more critical
they tend to become (Moon et al., 2009). As such, it could be expected that newer 
movies are rated worse than older movies because the frame of reference has increased. 
Additionally, with the rise of digital platforms and social media, review-bombing
has become an omnipresent phenomenon upon the release of new films. Moreover, there 
has been an increasingly vocal group that criticizes the franchise- and sequel-based 
strategies that movie corporations have adopted. Furthermore, it could be argued that 
movie consumers often experience nostalgia for films watched in their childhood, 
resulting in higher ratings for older movies. Authors such as Bollen et al. (2012) 
refer to this as a form of “positivity effect.” Overall, these findings underscore 
the expectation that newer films tend to be rated lower than older films, which 
will be tested with:

***H1:*** _Movies released after 2010 receive lower average ratings than movies released before 2010._

Animated films are more easily regarded as timeless, whereas the effect of H1 
might differ between the two categories. As such, animation remains memorable 
due to the distinct visual identity that is rooted in a fantasised setting. 
In addition, live-action characters' visible age or become outdated due to changes 
in fashion, technology or cultural norms, while animated characters remain fairly 
consistent over time (Larson, 2025). For example, Woody from Toy Story remains unchanged in 
sequels decades after his debut in 1995. On another note, animated films are often
targeted at children and families, which strengthens the sense of nostalgia through 
intergenerational re-watches (Lizardi, 2020). The present study will test this with:

***H2:*** _The negative effect of release year (before vs since 2010) on ratings is moderated by animation status, such that the decline is less pronounced for animated movies than for non-animated movies._

## Data

In order to test H1 and H2 and therefore answer the main research question,
secondary data is consulted from [IMDb.com](https://developer.imdb.com/non-commercial-datasets/).
The database holds several datasets, of which two provide relevance in the context
of the present study:

>[title.basics.tsv.gz](https://datasets.imdbws.com/title.basics.tsv.gz), which
>contains information about the title, runtime, genre and release year of motion 
>pictures.

>[title.rating.tsv.gz](https://datasets.imdbws.com/title.ratings.tsv.gz), which 
>provides data on ratings from all titles. These IMDb ratings are derived from 
>IMDb users and can comprise of movie consumers or professionals.

The dataset merged from the secondary data contains the following variables:

| Variable          | Type      | Definition                                                             |
|-------------------|-----------|-------------------------------------------------------------------------|
| tconst            | character | Unique IMDb identifier for each title                                   |
| primaryTitle      | character | The title most commonly used by the general public                      |
| startYear         | integer   | Year the title was released                                             |
| runtimeMinutes    | integer   | Runtime expressed in minutes                                            |
| genres            | character | Genres separated by commas                                              |
| averageRating     | numeric   | Weighted average IMDb user rating (0.0–10.0)                            |
| numVotes          | integer   | Number of votes received by the title                                   |
| before_2010_dummy | dummy     | Whether a movie is released before or after 2010                        |
| animation_dummy   | dummy     | Whether a movie is animated or not                                      |


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

_TO BE DONE_

-   Describe the gist of your findings (save the details for the final
    paper!)
-   How are the findings/end product of the project deployed?
-   Explain the relevance of these findings/product.




## Repository Overview

The structure of our repository is as follows:

``` text
project-name/
├─ reporting/
│  ├─ .gitkeep
│  ├─ report.Rmd
│  └─ start_app.R
├─ src/
│  ├─ analysis/
│  │  ├─ 1_descriptive_statistics.R
│  │  ├─ 2_exploratory_visualisations.R
│  │  ├─ 3_pre_assumption_check.R
│  │  ├─ 4_regression_analysis.R
│  │  ├─ 5_post_assumption_check.R
│  │  ├─ README.md
│  │  ├─ analysis_raw.R
│  │  ├─ assumption check_raw.R
│  │  └─ makefile
│  ├─data-preparation/
│  │  ├─ 1_download_raw_data.R
│  │  ├─ 2_merge_raw_data.R
│  │  ├─ 3_select_variables.R
│  │  ├─ 4_handling_missing_values.R
│  │  ├─ 5_filtering.R
│  │  ├─ 6_feature_engineering.R
│  │  ├─ README.md
│  │  └─ makefile
│  └─ .gitkeep
├─ paper
│  ├─ makefile
│  └─ paper.Rmd
├─ .RDataTmp
├─ .gitignore
├─ README.md
├─ makefile
└─ team-project-team2.Rproj
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

Bollen, D., Graus, M. P., & Willemsen, M. C. (2012). Remembering the
stars?: effect of time on preference retrieval from memory. Proceedings
of the sixth ACM conference on Recommender systems.<https://doi.org/10.1145/2365952.2365998>

Hadida, A. L., Lampel, J., Walls, W. D., & Joshi, A. (2020). Hollywood
Studio Filmmaking in the Age of Netflix: a Tale of Two Institutional
Logics. Journal of Cultural Economics, 45(2), 213–238. <https://doi.org/10.1007/s10824-020-09379-z>

Hennig-Thurau, T., Ravid, S. A., & Sorenson, O. (2021). The Economics of
Filmed Entertainment in the Digital Era. Journal of Cultural Economics,
45(2), 157–170. <https://doi.org/10.1007/s10824-021-09407-6>

Kumar, L. (2023, April). A Study On The Impact Of The OTT Platform On
The Cinema With The Special Reference On The Cinema Audience.
ResearchGate; unknown. <https://www.researchgate.net/publication/376650380_A_Study_On_The_Impact_Of_The_OTT_Platform_On_The_Cinema_With_The_Special_Reference_On_The_Cinema_Audience>

Larson, V. J. (2025). Philosophy in filmmaking: Animation vs. live action (Honors Program Theses No. 976) [Undergraduate thesis, University of Northern Iowa]. University of Northern Iowa Repository. https://scholarworks.uni.edu/cgi/viewcontent.cgi?article=2004&context=hpt>

Lizardi, R. (2020). The future of nostalgia is inevitable: Reflections on mediated nostalgia. In M. H. Jacobsen (Ed.), Nostalgia Now: Cross-disciplinary perspectives on the past in the present (1st ed., pp. 147-161). Routledge. https://doi.org/10.4324/9780429287602-8>

Moon, S., Bergey, P. K., & Iacobucci, D. (2009). Dynamic Effects among
Movie Ratings, Movie Revenues, and Viewer Satisfaction. Journal Of
Marketing, 74(1), 108–121. <https://doi.org/10.1509/jmkg.74.1.108>

Oberoi, S. (2024, December 3). The Evolution of Netflix: from DVD
Rentals to Global Streaming Leader. Seat11a.com. <https://seat11a.com/blog-the-evolution-of-netflix-from-dvd-rentals-to-global-streaming-leader/>

Ramos, M., Calvão, A. M., & Anteneodo, C. (2015). Statistical patterns in movie rating behavior. PLOS ONE, 10(8), e0136083. https://doi.org/10.1371/journal.pone.0136083>

Sun, Z. (2023). What does cgi digital technology bring to the
sustainable development of animated films?. Sustainability, 15(14),
10895.<https://doi.org/10.3390/su151410895>

Thompson, B. (2024, May 25). The Rise and Fall of Streaming TV? –
Michigan Journal of Economics. Michigan Journal of Economics. <https://sites.lsa.umich.edu/mje/2024/05/25/the-rise-and-fall-of-streaming-tv/>
