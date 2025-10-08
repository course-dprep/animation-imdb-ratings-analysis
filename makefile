
.PHONY: all data-preparation analysis paper

all: data-preparation analysis paper

data-preparation:
	make -C src/data-preparation
	
data-exploratino:
	make -C src/data-exploration

analysis: data-preparation
	make -C src/analysis

paper: analysis
	make -C paper