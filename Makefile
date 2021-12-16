.PHONY: clean-results clean-stan clean-all results

results:
	python prepare_data.py
	python generate_results.py

clean-stan:
	$(RM) $(shell find ./src/stan -perm +100 -type f)
	$(RM) ./src/stan/*.hpp

clean-results:
	$(RM) -r results/runs/*/

clean-raw-data:
	$(RM) data/raw/*.csv

clean-prepared-data:
	$(RM) -r $(shell find data/prepared/* -type d -maxdepth 0)

clean-all: clean-prepared-data clean-stan clean-results
