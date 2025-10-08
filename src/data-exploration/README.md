# **Data Exploration Information**

Below, the two files related to the data exploration are elaborated on.

---

### **7_descriptive_statistics.R**

This script provided descriptive statistics of the dataset resulting from the data preparation folder; *movies_prepped*.
Four subsets are created on which descriptive statistics are generated, which include;

1. *Animation subset*
2. *Non-Animation subset*
3. *Before 2010 subset*
4. *Since 2010 subset*

A function is created that computes statistics such as range and standard deviation for the variables
`runtimeMinutes`, `averageRating`, and `numVotes` across each subset, making it easy to compare different 
categories of films in the data exploration file.

---

### **8_exploratory_visualisations.R**

Using the *movies_prepped* file, patterns in the dataset are visualised in this script by creating a variety of 
plots and figures. These include;

1. *Histograms* to show the distribution of average ratings and the number of movies released per year, both split by animation type. 
2. *Line graphs* and smoothed trends to examine how average IMDb ratings have evolved over time, comparing animation and non-animation films. 
3. A *boxplot* to visualize differences in runtime between movie types. 

All plots are saved as image files for further discussion in the data exploration file.