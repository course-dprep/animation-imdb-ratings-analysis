
.PHONY: all data-preparation analysis paper

all: data-preparation analysis paper

data-preparation:
	make -C src/data-preparation

analysis: data-preparation
	make -C src/analysis

paper: analysis
	make -C paper