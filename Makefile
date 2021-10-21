.PHONY: clean-results clean-stan clean-all results

results:
	python prepare_data.py
	python generate_fake_data.py
	python sample.py

clean-stan:
	$(RM) $(shell find ./src/stan -perm +100 -type f)
	$(RM) ./src/stan/*.hpp

clean-results:
	$(RM) results/runs/*/*/*.csv
	$(RM) results/runs/*/*/*.txt
	$(RM) results/runs/*/*/*.nc
	$(RM) results/runs/*/*/*.pkl
	$(RM) results/runs/*/*/splits/*.csv
	$(RM) results/runs/*/*/splits/*.txt
	$(RM) results/runs/*/*/splits/*.nc
	$(RM) results/runs/*/*/splits/*.pkl

clean-prepared-data:
	$(RM) data/prepared/km_preprocessed.csv
	$(RM) -r $(shell find data/prepared/* -type d -maxdepth 0)

clean-all: clean-stan clean-results
