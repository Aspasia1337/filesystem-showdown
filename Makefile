# Makefile para compilar el TFG

.PHONY: build clean help

MAIN=thesis
XELATEX=xelatex
BIBER=biber
LATEXMK=latexmk

# Destino por defecto
help:
	@echo "Comandos disponibles:"
	@echo "  make build      - Compilar el documento (recomendado)"
	@echo "  make fast       - Compilación rápida con pdflatex"
	@echo "  make view       - Compilar y abrir el PDF"
	@echo "  make clean      - Eliminar archivos temporales"
	@echo "  make distclean  - Eliminar todos los archivos generados"

build:
	@echo "Compilando con XeLaTeX..."
	$(XELATEX) $(MAIN).tex
	$(BIBER) $(MAIN)
	$(XELATEX) $(MAIN).tex
	$(XELATEX) $(MAIN).tex
	@echo "✓ Compilación completada. Archivo: $(MAIN).pdf"

fast:
	@echo "Compilación rápida con pdflatex..."
	pdflatex $(MAIN).tex
	$(BIBER) $(MAIN)
	pdflatex $(MAIN).tex
	pdflatex $(MAIN).tex
	@echo "✓ Compilación completada. Archivo: $(MAIN).pdf"

view: build
	@echo "Abriendo PDF..."
ifeq ($(OS),Windows_NT)
	start $(MAIN).pdf
else ifeq ($(UNAME_S),Darwin)
	open $(MAIN).pdf
else
	xdg-open $(MAIN).pdf
endif

clean:
	@echo "Limpiando archivos temporales..."
	rm -f *.aux *.bbl *.blg *.fdb_latexmk *.fls *.log *.out *.toc *.lot *.lof
	rm -f *.xdv *.run.xml *.bcf *.loalgorithm *.locode
	@echo "✓ Limpieza completada"

distclean: clean
	@echo "Eliminando archivo PDF..."
	rm -f $(MAIN).pdf
	@echo "✓ Limpieza completa realizada"
