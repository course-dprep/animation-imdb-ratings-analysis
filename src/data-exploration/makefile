# Directories
DATA    := ../../data
TEMP    := ../../gen/temp
OUTPUT  := ../../gen/output

# Bestanden
OUTPUT_DIR := $(OUTPUT)
RMD_FILE   := Data_exploration.Rmd
PDF_FILE   := Data_exploration.pdf

# Main target
.PHONY: all step7 step8 step9 step10
all: step7 step8 step9

# Step 7: descriptive_statistics.R
step7: $(TEMP)/since_2010_subset.csv

$(TEMP)/animation_subset.csv \
$(TEMP)/non_animation_subset.csv \
$(TEMP)/before_2010_subset.csv \
$(TEMP)/since_2010_subset.csv: 7_descriptive_statistics.R $(TEMP)/movies_prepped.csv
	Rscript --vanilla $<

# Step 8: exploratory_visualisations.R
step8: $(OUTPUT)/boxplot_runtime.png

$(OUTPUT)/hist_average_rating.png \
$(OUTPUT)/hist_movies_per_year.png \
$(OUTPUT)/line_avg_rating_all.png \
$(OUTPUT)/line_avg_rating_by_type.png \
$(OUTPUT)/smooth_avg_rating_by_type.png \
$(OUTPUT)/boxplot_runtime.png: 8_exploratory_visualisations.R $(TEMP)/movies_prepped.csv
	Rscript --vanilla $<

# Step 9: knit R Markdown naar PDF
step9: $(PDF_FILE)

$(PDF_FILE): $(RMD_FILE)
	Rscript -e "rmarkdown::render('$<', output_file = '$(PDF_FILE)')"

# Step 10: Cleaning (optioneel)
step10:
	rm -f $(TEMP)/*.csv $(OUTPUT)/*.png $(PDF_FILE)
