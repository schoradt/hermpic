#############################################################
# Makefile for the instalation of the herm-pic latex        #
# package for Debian GNU/Linux.                             #
#                                                           #
# Version: 0.2                                              #
# Author: Sven Schoradt <schoradt@informatik.tu-cottbus.de> #
#############################################################

# Config section
LATEX = latex
DVIPS = dvips

PDFLATEX = pdflatex

INSTALL = install

# Edited for Debian GNU/Linux.
DESTDIR =

# path to install the latex packages
INSTALL_PATH = $(DESTDIR)/usr/share/texmf/tex/latex/herm-pic

#path to install the documentation
DOC_PATH = $(DESTDIR)/usr/share/doc/hermpic

all:

doc: psdoc pdfdoc

psdoc: herm-pic-doc.ps

pdfdoc: herm-pic-doc.pdf

install: herm-pic.sty doc_clean
	@echo "Installing package ..."
	@${INSTALL} herm-pic.sty ${INSTALL_PATH}
	@echo "Installing documentation ..."
	@${INSTALL} herm-pic-doc.* ${DOC_PATH}

doc_clean:
	@rm -f *.aux *.log *.toc *.bbl *.blg *~

clean:	doc_clean
	@rm -f *.dvi *.ps *.pdf *.ps*

FORCE: ;

# Rule pattern
%.ps:	%.dvi FORCE
	${DVIPS} -o $@ $<

%.dvi:	%.tex
	${LATEX} $<

%.pdf:	%.tex
	${PDFLATEX} $<
