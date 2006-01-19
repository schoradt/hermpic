#############################################################
# Makefile for testing of the herm-pic latex package        #
#                                                           #
# Version: 0.1                                              #
# Author: Sven Schoradt <schoradt@informatik.tu-cottbus.de> #
#############################################################

# Config Variable for tools used
ECHO     = echo
REMOVE   = rm -f
LINK     = ln -s

LATEX    = latex
DVIPS    = dvips
PDFLATEX = pdflatex

#############################################################

TESTS = $(wildcard test_*.tex)

TESTSPS = $(patsubst %.tex, %.ps, $(TESTS))

PREREQ = herm-pic.sty herm-rev.sty herm-pic-impl.sty herm-pic-erd.sty

#############################################################

all: $(PREREQ) $(TESTSPS)

%.ps:	%.dvi
	${DVIPS} -o $@ $<

%.dvi:	%.tex 
	@${ECHO} -n "Making test for "
	@${ECHO} $<
	@TEXINPUTS=:..;${LATEX} $<

%.sty: ../%.sty
	@${ECHO} -n "Making test link to module "
	@${ECHO} $@
	@${LINK} $< $@

%.pdf:	%.tex
	${PDFLATEX} $<

doc_clean: FORCE
	@${REMOVE} *.aux *.log *.toc *.bbl *.blg *~

clean: doc_clean
	@${REMOVE} *.dvi *.ps *.pdf
	@${REMOVE} *.sty

FORCE: ;
