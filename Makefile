#############################################################
# Makefile for the installation of the herm-pic latex       #
# package.                                                  #
#                                                           #
# Prepared for the debian packaging system.                 #
#                                                           #
# Version: pre 1.0                                              #
# Author: Sven Schoradt <schoradt@informatik.tu-cottbus.de> #
#############################################################

# Config Variable for tools used
ECHO = echo
REMOVE = rm -f

INSTALL = install

LATEX = latex
DVIPS = dvips

PDFLATEX = pdflatex

# directories
DESTDIR = 

# path to install the latex packages
DEB_INSTALL_PATH = $(DESTDIR)/usr/share/texmf/tex/latex/herm-pic
INSTALL_PATH = $(DESTDIR)/texmf/tex/latex/herm-pic

#path to install the documentation
DEB_DOC_PATH = $(DESTDIR)/usr/share/doc/hermpic
DOC_PATH = $(DESTDIR)/doc/hermpic

all:

doc: psdoc pdfdoc

psdoc: herm-pic-doc.ps

pdfdoc: herm-pic-doc.pdf

install:  herm-pic.sty herm-rev.sty herm-pic-impl.sty  herm-pic-old.sty doc_clean
	@${ECHO} "Installing package ..."
	@${INSTALL} herm-pic.sty ${INSTALL_PATH}
	@${INSTALL} herm-rev.sty ${INSTALL_PATH}
	@${INSTALL} herm-pic-impl.sty ${INSTALL_PATH}
	@${INSTALL} herm-pic-old.sty ${INSTALL_PATH}
	@${ECHO} "Installing documentation ..."
	@${INSTALL} herm-pic-doc.ps ${DOC_PATH}
	@${INSTALL} herm-pic-doc.pdf ${DOC_PATH}

test:
	@${ECHO} "Testing package ..."
	@cd test; make
	@${ECHO} "see under test/ for genereated test_*.ps files"

doc_clean:
	@${REMOVE} *.aux *.log *.toc *~
	@cd test; make doc_clean

clean:	doc_clean
	@${REMOVE} *.dvi *.ps *.pdf *.ps*
	@cd test; make clean

FORCE: ;

# Rule pattern
%.ps:	%.dvi
	${DVIPS} -o $@ $<

%.dvi:	%.tex
	${LATEX} $<
	${LATEX} $<

%.pdf:	%.tex
	${PDFLATEX} $<

.PHONY: test clean doc_clean all doc psdoc pdfdoc 
