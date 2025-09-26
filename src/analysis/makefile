DATA    = ../../data
TEMP    = ../../gen/temp
OUTPUT  = ../../gen/output

# Main target: alles wat jij in analysis maakt
all: subsets plots regressions

# Step 1: Subsetting (levert meerdere CSV’s op)
subsets: $(OUTPUT)/movies_prepped.csv
	Rscript --vanilla 1_subsetting.R

# Step 2: Exploratory visualizations (meerdere PNG’s)
plots: $(OUTPUT)/movies_prepped.csv
	Rscript --vanilla 2_Exploratory_Visualizations.R

# Step 3: Pre Assumption check
$(OUTPUT)/movies.csv: $(OUTPUT)/movies_prepped.csv 3_Pre_Assumption_Check.R
	Rscript --vanilla 3_Pre_Assumption_Check.R

# Step 4: Regression analysis (meerdere CSV’s)
regressions: $(OUTPUT)/movies.csv
	Rscript --vanilla 4_Regression_Analysis.R
	
#step 5: post assumption check
