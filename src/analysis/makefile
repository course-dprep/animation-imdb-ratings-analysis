DATA    = ../../data
TEMP    = ../../gen/temp
OUTPUT  = ../../gen/output

# Main target
.PHONY: all
all: step9 step10 step11 step12

# Define what each step means
.PHONY: step9 step10 step11 step12
step9: $(OUTPUT)/ttest_rating.txt
step10: $(OUTPUT)/movies.csv
step11: $(OUTPUT)/lr_model_basic.txt
step12: $(OUTPUT)/assumption_checks_model1.txt

# Step9: T-Test
$(OUTPUT)/ttest_rating.txt: 9_t-test.R $(TEMP)/movies_prepped.csv
	Rscript --vanilla $<
	
# Step10: Pre assumption check
$(OUTPUT)/movies.csv: 10_pre_assumption_check.R $(TEMP)/movies_prepped.csv
	Rscript --vanilla $<

# Step11: Regression analysis
$(OUTPUT)/lr_model_basic.txt \
$(OUTPUT)/lr_model_with_control_variables.txt \
$(OUTPUT)/lr_model_with_interaction.txt \
$(OUTPUT)/MODEL1_unstandardised.rds \
$(OUTPUT)/MODEL2_unstandardised.rds \
$(OUTPUT)/MODEL3_unstandardised.rds: 11_regression_analysis.R $(OUTPUT)/movies.csv
	Rscript --vanilla $<
	
# Step12: Post assumption check
$(OUTPUT)/assumption_checks_model1.txt \
$(OUTPUT)/assumption_checks_model2.txt \
$(OUTPUT)/assumption_checks_model3.txt \
$(OUTPUT)/assumptions_histogram_MODEL1_unstandardised.png \
$(OUTPUT)/assumptions_histogram_MODEL2_unstandardised.png \
$(OUTPUT)/assumptions_histogram_MODEL3_unstandardised.png \
$(OUTPUT)/assumptions_plot_ZPREDvsZRESID_MODEL1_unstandardised.png \
$(OUTPUT)/assumptions_plot_ZPREDvsZRESID_MODEL2_unstandardised.png \
$(OUTPUT)/assumptions_plot_ZPREDvsZRESID_MODEL3_unstandardised.png: 12_post_assumption_check.R $(OUTPUT)/MODEL1_unstandardised.rds $(OUTPUT)/MODEL2_unstandardised.rds $(OUTPUT)/MODEL3_unstandardised.rds
	Rscript --vanilla $<
