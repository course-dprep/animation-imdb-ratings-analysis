
DATA = ../../data
TEMP = ../../gen/temp
OUTPUT = ../../gen/output

# Main target: final dataset
all: $(OUTPUT)/movies.csv

# Step 1: Download raw data
$(DATA)/raw_basics.csv $(DATA)/raw_ratings.csv: 1_download_raw_data.R
	Rscript --vanilla $<

# Step 2: Merge raw data
$(TEMP)/raw_combined.csv: 2_merge_raw_data.R $(DATA)/raw_basics.csv $(DATA)/raw_ratings.csv
	Rscript --vanilla $<

# Step 3: Select variables
$(TEMP)/movies_selected.csv: 3_select_variables.R $(TEMP)/raw_combined.csv
	Rscript --vanilla $<

# Step 4: Handle missing values
$(TEMP)/movies_imputed.csv: 4_handling_missing_values.R $(TEMP)/movies_selected.csv
	Rscript --vanilla $<

# Step 5: Filtering
$(TEMP)/movies_filtered.csv: 5_filtering.R $(TEMP)/movies_imputed.csv
	Rscript --vanilla $<

# Step 6: Feature engineering
$(OUTPUT)/movies.csv: 6_feature_engineering.R $(TEMP)/movies_filtered.csv
	Rscript --vanilla $<
