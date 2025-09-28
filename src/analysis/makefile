DATA    = ../../data
TEMP    = ../../gen/temp
OUTPUT  = ../../gen/output

# Main target: alles wat jij in analysis maakt
all: \
  $(OUTPUT)/animation_subset.csv \
  $(OUTPUT)/non_animation_subset.csv \
  $(OUTPUT)/before_2010_subset.csv \
  $(OUTPUT)/since_2010_subset.csv \
  $(OUTPUT)/hist_movies_per_year.png \
  $(OUTPUT)/hist_average_rating.png \
  $(OUTPUT)/line_avg_rating_all.png \
  $(OUTPUT)/line_avg_rating_by_type.png \
  $(OUTPUT)/smooth_avg_rating_by_type.png \
  $(OUTPUT)/boxplot_runtime.png \
  $(OUTPUT)/ttest_animation.csv \
  $(OUTPUT)/movies.csv \
  $(OUTPUT)/version2.rds \
  $(OUTPUT)/lr_model_basic.txt \
  $(OUTPUT)/lr_model_with_control_variables.txt \
  $(OUTPUT)/lr_model_with_extra_dummy.txt \
  $(OUTPUT)/assumptions_histogram.png \
  $(OUTPUT)/assumptions_ZPRED_vs_ZRESID_plot.png
  
# Step 1: Subsetting (levert meerdere CSV’s op)
$(OUTPUT)/animation_subset.csv $(OUTPUT)/non_animation_subset.csv $(OUTPUT)/before_2010_subset.csv $(OUTPUT)/since_2010_subset.csv: 1_descriptive_statistics.R $(TEMP)/movies_prepped.csv
	Rscript --vanilla $<

# Step 2: Exploratory visualizations (meerdere PNG’s)
$(OUTPUT)/hist_movies_per_year.png \
$(OUTPUT)/hist_average_rating.png \
$(OUTPUT)/line_avg_rating_all.png \
$(OUTPUT)/line_avg_rating_by_type.png \
$(OUTPUT)/smooth_avg_rating_by_type.png \
$(OUTPUT)/boxplot_runtime.png \
$(OUTPUT)/ttest_animation.csv: 2_exploratory_visualisations.R $(TEMP)/movies_prepped.csv
	Rscript --vanilla $<

	
# Step 3: Pre Assumption check
$(OUTPUT)/movies.csv: 3_pre_assumption_Check.R $(TEMP)/movies_prepped.csv
	Rscript --vanilla $<

# Step 4: Regression analysis (meerdere CSV’s)
$(OUTPUT)/version2.rds $(OUTPUT)/lr_model_basic.txt $(OUTPUT)/lr_model_with_control_variables.txt $(OUTPUT)/lr_model_with_extra_dummy.txt: 4_regression_analysis.R $(OUTPUT)/movies.csv
	Rscript --vanilla $<
	
#step 5: post assumption check
$(OUTPUT)/assumptions_histogram.png $(OUTPUT)/assumptions_ZPRED_vs_ZRESID_plot.png: 5_post_assumption_check.R $(OUTPUT)/version2.rds
	Rscript --vanilla $<