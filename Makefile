.PHONY: clean-results clean-stan clean-all results

results:
	python prepare_data.py
	python generate_results.py

plots:
	python analyse.py

clean-stan:
	$(RM) $(shell find ./src/stan -perm +100 -type f) # remove binary files
	$(RM) ./src/stan/*.hpp

clean-results:
	$(RM) -r results/runs/*/

clean-prepared-data:
	$(RM) -r data/prepared/*/

clean-plots:
	$(RM) results/plots/*.png
	$(RM) results/plots/*.svg

clean-all: clean-prepared-data clean-stan clean-results
