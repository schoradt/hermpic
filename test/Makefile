#############################################################
# Makefile for testing of the herm-pic latex package        #
#                                                           #
# Version: 0.1                                              #
# Author: Sven Schoradt <schoradt@informatik.tu-cottbus.de> #
#############################################################

# Config Variable for tools used
ECHO = echo
REMOVE = rm -f
LINK = ln -s

INSTALL = install

LATEX = latex
DVIPS = dvips

SHELL = /bin/sh

#############################################################

TESTS = $(wildcard test_*.tex)

TESTSPS = $(patsubst %.tex, %.ps, $(TESTS))

#############################################################

all: ../herm-pic.sty $(TESTSPS)

%.ps:	%.dvi
	${DVIPS} -o $@ $<

%.dvi:	%.tex herm-pic.sty herm-rev.sty herm-pic-impl.sty herm-pic-erd.sty
	@${ECHO} -n "   Making test for "
	@${ECHO} $<
	@TEXINPUTS=:..;${LATEX} $<

herm-pic.sty: ../herm-pic.sty
	@${ECHO} "Making test link to module ..."
	@${LINK} $< $@

herm-rev.sty: ../herm-rev.sty
	@${ECHO} "Making test link to module ..."
	@${LINK} $< $@

herm-pic-impl.sty: ../herm-pic-impl.sty
	@${ECHO} "Making test link to module ..."
	@${LINK} $< $@

herm-pic-erd.sty: ../herm-pic-erd.sty
	@${ECHO} "Making test link to module ..."
	@${LINK} $< $@

doc_clean: FORCE
	@${REMOVE} *.aux *.log *.toc *.bbl *.blg *~

clean: doc_clean
	@${REMOVE} *.dvi *.ps *.pdf
	@${REMOVE} *.sty

FORCE: ;
