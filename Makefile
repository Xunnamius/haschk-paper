BIBTEX=bibtex
PDFLATEX=pdflatex
GHOSTSCRIPT=\gs

TEX-FILES = *.tex
BIB-FILES = *.bib
TOP-LEVEL-ROOT = _paper
CRNAME = dickens-haschk


all: generate-pdf save-temporary $(CRNAME)

generate-pdf: ${TEX-FILES} ${BIB-FILES}
	mkdir -p out
	$(PDFLATEX) -shell-escape ${TOP-LEVEL-ROOT}
	#$(PDFLATEX) -shell-escape ${TOP-LEVEL-ROOT}
	$(BIBTEX) ${TOP-LEVEL-ROOT}
	$(PDFLATEX) -shell-escape ${TOP-LEVEL-ROOT}
	$(PDFLATEX) -shell-escape ${TOP-LEVEL-ROOT}

save-temporary: generate-pdf
	mkdir -p out
	if test -e *.gz;  then mv *.gz out;  fi
	if test -e *.aux; then mv *.aux out; fi
	if test -e *.blg; then mv *.blg out; fi
	if test -e *.bbl; then mv *.bbl out; fi
	if test -e *.out; then mv *.out out; fi
	if test -e *.log; then mv *.log out; fi
	if test -e *.xml; then mv *.xml out; fi
	if test -e *.fls; then mv *.fls out; fi
	if test -e *.toc; then mv *.toc out; fi
	if test -e *.lot; then mv *.lot out; fi
	if test -e *.lof; then mv *.lof out; fi
	if test -e *.fdb*; then mv *.fdb* out; fi
	if test -e *.auxlock; then mv *.auxlock out; fi
	if test -e *blx.bib; then mv *blx.bib out; fi
	if test -e out/_minted*; then rm -rf out/_minted*; fi
	if test -e _minted*; then mv -f _minted* out; fi

$(CRNAME): $(TOP-LEVEL-ROOT).pdf
	$(GHOSTSCRIPT) -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dEmbedAllFonts=true -sOutputFile=$(CRNAME).pdf -f $(TOP-LEVEL-ROOT).pdf

clean:
	rm -rf *.gz *.aux *.blg *.bbl *.out *.log *.xml *.fls *.toc *.lot *.lof *.fdb* *.auxlock *blx.bib out/_minted* _minted* out
	mkdir out
	touch out/.gitkeep
