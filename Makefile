# Makefile for TikZ Project
# Usage: make [target]

# Variables
MAIN = main
LATEX = pdflatex
BIBTEX = bibtex
OUTPUT_DIR = output

# Default target
.PHONY: all
all: $(OUTPUT_DIR)/$(MAIN).pdf

# Create output directory if it doesn't exist
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Compile main document
$(OUTPUT_DIR)/$(MAIN).pdf: $(MAIN).tex tikz/examples/*.tex styles/*.tex | $(OUTPUT_DIR)
	$(LATEX) -output-directory=$(OUTPUT_DIR) $(MAIN).tex
	# Run twice to resolve references
	$(LATEX) -output-directory=$(OUTPUT_DIR) $(MAIN).tex

# Compile with bibliography (if needed)
.PHONY: bib
bib: $(OUTPUT_DIR)/$(MAIN).pdf
	cd $(OUTPUT_DIR) && $(BIBTEX) $(MAIN)
	$(LATEX) -output-directory=$(OUTPUT_DIR) $(MAIN).tex
	$(LATEX) -output-directory=$(OUTPUT_DIR) $(MAIN).tex

# Compile individual TikZ files as standalone documents
.PHONY: standalone
standalone:
	@echo "Compiling standalone TikZ files..."
	@for file in tikz/figures/*.tex; do \
		if [ -f "$$file" ]; then \
			echo "Compiling $$file..."; \
			$(LATEX) -output-directory=$(OUTPUT_DIR) "$$file"; \
		fi; \
	done

# Compile examples
.PHONY: examples
examples: $(OUTPUT_DIR)
	@echo "Compiling example files..."
	@for file in tikz/examples/*.tex; do \
		if [ -f "$$file" ]; then \
			basename=$$(basename "$$file" .tex); \
			echo "\\documentclass[tikz,border=5pt]{standalone}" > $(OUTPUT_DIR)/standalone_$$basename.tex; \
			echo "\\input{../styles/common-styles.tex}" >> $(OUTPUT_DIR)/standalone_$$basename.tex; \
			echo "\\begin{document}" >> $(OUTPUT_DIR)/standalone_$$basename.tex; \
			cat "$$file" >> $(OUTPUT_DIR)/standalone_$$basename.tex; \
			echo "\\end{document}" >> $(OUTPUT_DIR)/standalone_$$basename.tex; \
			$(LATEX) -output-directory=$(OUTPUT_DIR) $(OUTPUT_DIR)/standalone_$$basename.tex; \
		fi; \
	done

# Clean intermediate files
.PHONY: clean
clean:
	rm -f $(OUTPUT_DIR)/*.aux
	rm -f $(OUTPUT_DIR)/*.log
	rm -f $(OUTPUT_DIR)/*.toc
	rm -f $(OUTPUT_DIR)/*.out
	rm -f $(OUTPUT_DIR)/*.bbl
	rm -f $(OUTPUT_DIR)/*.blg
	rm -f $(OUTPUT_DIR)/*.fls
	rm -f $(OUTPUT_DIR)/*.fdb_latexmk
	rm -f $(OUTPUT_DIR)/*.synctex.gz

# Clean everything including PDFs
.PHONY: cleanall
cleanall: clean
	rm -f $(OUTPUT_DIR)/*.pdf
	rm -f $(OUTPUT_DIR)/standalone_*.tex

# Watch for changes and recompile (requires inotify-tools)
.PHONY: watch
watch:
	@echo "Watching for changes... (Press Ctrl+C to stop)"
	@while inotifywait -e modify,create,delete -r . --exclude '$(OUTPUT_DIR)' >/dev/null 2>&1; do \
		echo "Files changed, recompiling..."; \
		make -s all; \
	done

# Show help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all        - Compile main document (default)"
	@echo "  bib        - Compile with bibliography"
	@echo "  standalone - Compile individual TikZ figures"
	@echo "  examples   - Compile example TikZ files as standalone documents"
	@echo "  clean      - Remove intermediate files"
	@echo "  cleanall   - Remove all generated files"
	@echo "  watch      - Watch for changes and recompile automatically"
	@echo "  help       - Show this help message"
