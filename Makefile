.phony = clean-all clean-stan clean-results clean-pdf clean-data

QUOTE_LINES = sed "s/^/'/;s/$$/'/"  # pipe this to make sure filenames are quoted
BIBLIOGRAPHY = bibliography.bib
CMDSTAN_LOGS = $(shell find results/samples -type f -name "*.txt" | $(QUOTE_LINES))
STAN_OBJECT_CODE = \
  $(shell find src/stan -type f \( -not -name "*.stan" -not -name "*.md" \) \
  | $(QUOTE_LINES))
SAMPLES = $(shell find results/samples -name "*.csv" | $(QUOTE_LINES))
FAKE_DATA = $(shell find data/fake -type f -name "*.csv" | $(QUOTE_LINES))
PREPARED_DATA = $(shell find data/prepared -name "*.csv" | $(QUOTE_LINES))
IDATAS = $(shell find results/idata -type f -not -name "idata*.nc" | $(QUOTE_LINES))
LOOS = $(shell find results/loo -type f -not -name "*.md" | $(QUOTE_LINES))
JSONS = $(shell find results/input_data_json -type f -not -name "*.md" | $(QUOTE_LINES))
MARKDOWN_FILE = report.md
ORG_FILE = report.org
PDF_FILE = report.pdf
DOCX_FILE = report.docx
PANDOCFLAGS =                         \
  --from=org                          \
  --highlight-style=pygments          \
  --pdf-engine=xelatex                \
  --citeproc                          \
  --bibliography=$(BIBLIOGRAPHY)      

$(PDF_FILE): $(ORG_FILE) $(BIBLIOGRAPHY)
	pandoc $< -o $@ $(PANDOCFLAGS)

$(DOCX_FILE): $(ORG_FILE) $(BIBLIOGRAPHY)
	pandoc $< -o $@ --from=markdown --bibliography=$(BIBLIOGRAPHY)

clean-all: clean_stan clean_results clean_pdf clean_data

clean-data:
	$(RM) $(FAKE_DATA) $(PREPARED_DATA)

clean-stan:
	$(RM) $(CMDSTAN_LOGS) $(STAN_OBJECT_CODE)

clean-results:
	$(RM) $(SAMPLES) $(IDATAS) $(LOOS) $(PLOTS) $(JSONS) $(CMDSTAN_LOGS)

clean-pdf:
	$(RM) $(PDF_FILE)
