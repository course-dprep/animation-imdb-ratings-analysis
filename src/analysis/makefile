
DATA    = ../../data
TEMP    = ../../gen/temp
OUTPUT  = ../../gen/output

# Main target
all: $(OUTPUT)/assumption_checks_model1.txt \
$(OUTPUT)/assumption_checks_model2.txt \
$(OUTPUT)/assumption_checks_model3.txt \
$(OUTPUT)/assumptions_histogram_MODEL1_unstandardised.png \
$(OUTPUT)/assumptions_histogram_MODEL2_unstandardised.png \
$(OUTPUT)/assumptions_histogram_MODEL3_unstandardised.png \
$(OUTPUT)/assumptions_plot_ZPREDvsZRESID_MODEL1_unstandardised.png \
$(OUTPUT)/assumptions_plot_ZPREDvsZRESID_MODEL2_unstandardised.png \
$(OUTPUT)/assumptions_plot_ZPREDvsZRESID_MODEL3_unstandardised.png

# Step 1: Descriptive statistics
$(OUTPUT)/animation_subset.csv \
$(OUTPUT)/non_animation_subset.csv \
$(OUTPUT)/before_2010_subset.csv \
$(OUTPUT)/since_2010_subset.csv: 1_descriptive_statistics.R $(TEMP)/movies_prepped.csv
	Rscript --vanilla $<

# Step 2: Exploratory visualisations
$(OUTPUT)/hist_average_rating.png \
$(OUTPUT)/hist_movies_per_year.png \
$(OUTPUT)/line_avg_rating_all.png \
$(OUTPUT)/line_avg_rating_by_type.png \
$(OUTPUT)/smooth_avg_rating_by_type.png \
$(OUTPUT)/boxplot_runtime.png: 2_exploratory_visualisations.R $(TEMP)/movies_prepped.csv
	Rscript --vanilla $<

# Step 3: T-Test
$(OUTPUT)/ttest_rating.txt: t-test.R $(TEMP)/movies_prepped.csv
	Rscript --vanilla $<
	
# Step 4: Pre assumption check
$(OUTPUT)/movies.csv: 4_pre_assumption_check.R $(TEMP)/movies_prepped.csv
	Rscript --vanilla $<

# Step 5: Regression analysis
$(OUTPUT)/lr_model_basic.txt \
$(OUTPUT)/lr_model_with_control_variables.txt \
$(OUTPUT)/lr_model_with_interaction.txt \
$(OUTPUT)/MODEL1_unstandardised.rds \
$(OUTPUT)/MODEL2_unstandardised.rds \
$(OUTPUT)/MODEL3_unstandardised.rds: 5_regression_analysis.R $(OUTPUT)/movies.csv
	Rscript --vanilla $<
	
# Step 6: Post assumption check
$(OUTPUT)/assumption_checks_model1.txt \
$(OUTPUT)/assumption_checks_model2.txt \
$(OUTPUT)/assumption_checks_model3.txt \
$(OUTPUT)/assumptions_histogram_MODEL1_unstandardised.png \
$(OUTPUT)/assumptions_histogram_MODEL2_unstandardised.png \
$(OUTPUT)/assumptions_histogram_MODEL3_unstandardised.png \
$(OUTPUT)/assumptions_plot_ZPREDvsZRESID_MODEL1_unstandardised.png \
$(OUTPUT)/assumptions_plot_ZPREDvsZRESID_MODEL2_unstandardised.png \
$(OUTPUT)/assumptions_plot_ZPREDvsZRESID_MODEL3_unstandardised.png: 6_post_assumption_check.R $(OUTPUT)/MODEL1_unstandardised.rds $(OUTPUT)/MODEL2_unstandardised.rds $(OUTPUT)/MODEL3_unstandardised.rds
	Rscript --vanilla $<