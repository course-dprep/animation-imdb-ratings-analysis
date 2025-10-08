
# Makefile for rendering the research paper


OUTPUT = ../gen/output
PAPER  = paper.Rmd
PDF    = paper.pdf

.PHONY: all clean figs

# Main target: build the paper

all: $(PDF)

# Ensure that all figures and analysis outputs exist first

figs:
	make -C ../src/data-exploration step8

# Build the paper (depends on figs + required analysis outputs)

$(PDF): figs $(PAPER) \
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


# Clean up generated files

clean:
	rm -f $(PDF)
