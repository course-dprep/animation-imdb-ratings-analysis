DATA    = ../../data
TEMP    = ../../gen/temp
OUTPUT  = ../../gen/output

# Main target: alles wat jij in analysis maakt
all: subsets plots regressions

# Step 1: Subsetting (levert meerdere CSV’s op)
subsets: $(OUTPUT)/movies.csv
	Rscript --vanilla 1_subsetting.R

# Step 2: Exploratory visualizations (meerdere PNG’s)
plots: $(OUTPUT)/movies.csv
	Rscript --vanilla 2_Exploratory_Visualizations.R

# Step 3: Regression analysis (meerdere CSV’s)
regressions: $(OUTPUT)/movies.csv
	Rscript --vanilla 3_Regression_Analysis.R
	
# Step 4: Checking model assumptions
