.phony = clean-all clean-pdf

BIBLIOGRAPHY = bibliography.bib
ORG-FILE = slides.org
PDF-FILE = slides.pdf
PANDOCFLAGS =                           \
  --from=org                            \
  --to=beamer                           \
  --highlight-style=pygments            \
  --citeproc                            \
  --bibliography=$(BIBLIOGRAPHY)        \
  --toc                                 \
  --include-before=include_before.latex \
  --slide-level 2

$(PDF-FILE): $(ORG-FILE) $(BIBLIOGRAPHY)
	TEXINPUTS='./template//:' pandoc $< -o $@ $(PANDOCFLAGS)

clean-all: clean-pdf

clean-pdf:
	$(RM) $(PDF-FILE)
