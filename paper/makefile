OUTPUT = ../gen/output
PAPER = paper.Rmd
PDF = paper.pdf

.PHONY: all clean

all: $(PDF)

$(PDF): $(PAPER) \
	$(OUTPUT)/ttest_rating.txt \
	$(OUTPUT)/lr_model_basic.txt \
	$(OUTPUT)/lr_model_with_control_variables.txt \
	$(OUTPUT)/lr_model_with_interaction.txt \
	$(OUTPUT)/hist_average_rating.png \
	$(OUTPUT)/line_avg_rating_all.png \
	$(OUTPUT)/line_avg_rating_by_type.png \
	$(OUTPUT)/smooth_avg_rating_by_type.png \
	$(OUTPUT)/boxplot_runtime.png
	Rscript -e "rmarkdown::render('$(PAPER)', output_file = '$(PDF)', output_format = 'pdf_document', output_dir = '.')"

clean:
	rm -f $(PDF)