.PHONY: all data-preparation data-exploration analysis paper clean

all: data-preparation data-exploration analysis paper

data-preparation:
	make -C src/data-preparation

data-exploration: data-preparation
	make -C src/data-exploration

analysis: data-exploration
	make -C src/analysis

paper: analysis
	make -C paper

clean:
	Rscript -e "unlink('data', recursive = TRUE)"
	Rscript -e "unlink('gen', recursive = TRUE)"
