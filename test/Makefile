#############################################################
# Makefile for testing of the herm-pic latex package        #
#                                                           #
# Version: 0.1                                              #
# Author: Sven Schoradt <schoradt@informatik.tu-cottbus.de> #
#############################################################

SHELL = /bin/tcsh

# Include configuration file
include ../Makefile.config

#############################################################

TESTS = $(wildcard test_*.tex)

TESTSPS = $(patsubst %.tex, %.ps, $(TESTS))

#############################################################

all: ../herm-pic.sty $(TESTSPS)

%.ps:	%.dvi
	${DVIPS} -o $@ $<

%.dvi:	%.tex ../herm-pic.sty
	@echo -n "   Making test for "
	@echo $<
	setenv TEXINPUTS :..;${LATEX} $<

doc_clean:
	rm -f *.aux *.log *.toc *.bbl *.blg *~

clean:
	rm -f *.dvi *.ps *.pdf *.ps*


