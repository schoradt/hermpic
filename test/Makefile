#############################################################
# Makefile for testing of the herm-pic latex package        #
#                                                           #
# Version: 0.1                                              #
# Author: Sven Schoradt <schoradt@informatik.tu-cottbus.de> #
#############################################################

# Include configuration file
include ../Makefile.config

SHELL = /bin/sh

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
	@TEXINPUTS=:..;${LATEX} $<

doc_clean: FORCE
	@rm -f *.aux *.log *.toc *.bbl *.blg *~

clean: doc_clean
	@rm -f *.dvi *.ps *.pdf

FORCE: ;
