# About Time: Predicting IMDb Movie Ratings with Release Year and the effect of Animation

## Motivation
Movies -a form of entertainment that has been around for centuries. Yet, the 
distribution and consumer perceptions of movies have shifted since the introduction 
of streaming services (Hennig-Hurau et al., 2021; Kumar, 2023). In 2010, the 
international expansion of Netflix across the globe marked a key point in the 
growth of on-demand content (Oberoj, 2024). The saturation and availability of 
the entertainment market have resulted in more critical consumers, which seemingly 
affects how audiences evaluate films (Hadida et al., 2020). Although research 
has been performed on movie ratings over time (e.g. Moon et al., 2010, Ramos et 
al., 2015), the effect of streaming remains rather unexplored.

Over the years, black-and-white deaf movies have advanced to colourful and 
effects-heavy motion pictures due to technological developments. This is 
especially prominent in animation, where disruptions in Computer Generated 
Images (CGI) and production techniques have significantly enhanced visual 
quality and storytelling opportunities (Sun, 2023). Consequently, audience 
evaluations of animated films could differ from live-action films.  Yet, 
current research has not addressed this focus on animation.

All-in all, the present study provides academic relevance by investigating the 
temporal dynamics on  the quality perception of movies, while also accounting 
for the effect of animation. These insights are also socially relevant for 
filmmakers and distributors to better understand audiences. The focus of the 
research can be encapsulated with the following research question:

### Research Question

*To what extent does the release year of a movie influence its average IMDb rating,
and does this relationship differ between animated and non-animated films?*

## Hypotheses

Since 2010, the film industry has been shaken on its foundations due to
the increasing popularity of streaming platforms (Hennig-Thurau et al.,
2021). At that time, Netflix expanded their streaming service
internationally, marking a key point in the growth of on-demand content
(Oberoi, 2024). Distribution patterns changed, and consumer perceptions
of movies have shifted (Kumar, 2023). Most notably, the saturation and
availability of the entertainment market have resulted in more critical
consumers (Hadida et al., 2020). Additionally, there has been an increasingly 
more vocal group that criticises the franchise and sequel-based strategy that 
movie corporations have integrated. As more streaming services entered the market, 
the competitiveness in this market rose, which led to a bigger variety in TV 
shows and movies offered (Thompson, 2024). This is also shown in the rising number of
movies, series and other content per year in the IMDb dataset. The more
experienced a viewer is in watching movies, the more critical they
become (Moon et al., 2009). Furthermore, it could be reasoned that movie
consumers grew up with evoke a sense of nostalgia, leading to higher
ratings of older films. Authors such as Bollen et al. (2012) refer to
this as a form of “positivity effect”. Additionally, with the rise of
digital platforms and social media, review-bombing has been an
omnipresent effect with the release of new movies. All in all, these
findings suggest that newer films are rated worse than older films,
which the present study tests with the hypothesis:

H1: There is a negative relationship between release year and rating.


Therefore, this allows to expect:

H2: The negative effect of release year on rating is weaker for animated
films compared to non-animated films.

## Data

Secondary data is consulted from [IMDb.com](https://developer.imdb.com/non-commercial-datasets/).
The database holds several datasets, of which two provide relevance in the context
of the present study:

1. [title.basics.tsv.gz](https://datasets.imdbws.com/title.basics.tsv.gz), which
contain information about the title, runtime, genre and release year of motion 
pictures.

2. [title.rating.tsv.gz](https://datasets.imdbws.com/title.ratings.tsv.gz), which 
provides data on ratings from all titles. These IMDb ratings are derived from 
IMDb users and can comprise or movie consumers or professionals.

## Method

To test the hypothesis, a linear regression was conducted. Release year
was treated as the independent variable, and average IMDb user rating as the
dependent variable. 

Whether a movie was an animation was dummy coded (0 = non-animated, 1 = animated) 
and included as a moderator to test whether it has a significant effect on the 
relationship from release year to the average rating.

Other potential factors that were not specifically hypothesised but could 
influence ratings were included as control variables. This concerned runtime,
and number of votes. 


## Preview of Findings

_TO BE DONE_

-   Describe the gist of your findings (save the details for the final
    paper!)
-   How are the findings/end product of the project deployed?
-   Explain the relevance of these findings/product.

## Repository Overview

The structure of our repository is as follows:

``` text
project-naam/
├─ data/
│  └─ download-data.R
├─ reporting/
│  ├─ report.Rmd
│  └─ start_app.R
├─ src/
│  ├─ analysis/
│  │  └─ analysis.R
│  └─ data-preparation/
│     ├─ 1. Importing Data.R
│     ├─ DataPreperation.Rmd
│     └─ first-data-cleaning.R
├─ .gitignore
├─ README.md
├─ makefile
└─ team-project-team2.Rproj
```

## Dependencies

For data downloading, cleaning and analysing R and R studio were used.

``` r
# Install the following packages
install.packages("readr")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("rmarkdown")
install.packages("tidyverse")
install.packages("base")
install.packages("datasets")
install.packages("googledrive")
install.packages("graphics")
install.packages("grDevices")
install.packages("methods")
install.packages("stats")
install.packages("utils")
```

## About

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the
[Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing),
[Tilburg University](https://www.tilburguniversity.edu/), The
Netherlands. The project is implemented by team 2: 
- Britt van Haaster 
- Isah Huijbregts 
- Lars van der Kroft 
- Amanda van Lankveld 
- Amy Quist
- Stefan Valentijn

## Sources

Billy Thompson. (2024, May 25). The Rise and Fall of Streaming TV? –
Michigan Journal of Economics. Michigan Journal of Economics. <https://sites.lsa.umich.edu/mje/2024/05/25/the-rise-and-fall-of-streaming-tv/>

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

Moon, S., Bergey, P. K., & Iacobucci, D. (2009). Dynamic Effects among
Movie Ratings, Movie Revenues, and Viewer Satisfaction. Journal Of
Marketing, 74(1), 108–121. <https://doi.org/10.1509/jmkg.74.1.108>

Oberoi, S. (2024, December 3). The Evolution of Netflix: from DVD
Rentals to Global Streaming Leader. Seat11a.com. <https://seat11a.com/blog-the-evolution-of-netflix-from-dvd-rentals-to-global-streaming-leader/>

Sun, Z. (2023). What does cgi digital technology bring to the
sustainable development of animated films?. Sustainability, 15(14),
10895.<https://doi.org/10.3390/su151410895>
