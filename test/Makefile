#############################################################
# Makefile for testing of the herm-pic latex package        #
#                                                           #
# Version: 0.1                                              #
# Author: Sven Schoradt <schoradt@informatik.tu-cottbus.de> #
#############################################################

# Include configuration file
include ../Makefile.config

SHELL = /bin/tcsh

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

doc_clean: FORCE
	rm -f *.aux
	rm -f *.log 
	rm -f *.toc 
	rm -f *.bbl 
	rm -f *.blg 
	rm -f *~

clean:
	rm -f *.dvi 
	rm -f *.ps
	rm -f *.pdf
	rm -f *.ps*

FORCE: ;
