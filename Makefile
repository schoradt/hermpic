#############################################################
# Makefile for the installation of the herm-pic latex       #
# package.                                                  #
#                                                           #
# Prepared for the debian packaging system.                 #
#                                                           #
# Version: 0.7                                              #
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
INSTALL_PATH = $(DESTDIR)/usr/share/texmf/tex/latex/herm-pic

#path to install the documentation
DOC_PATH = $(DESTDIR)/usr/share/doc/hermpic

all:

doc: psdoc pdfdoc

psdoc: herm-pic-doc.ps

pdfdoc: herm-pic-doc.pdf

install: Makefile.config herm-pic.sty doc_clean
	@${ECHO} "Installing package ..."
	@${INSTALL} herm-pic.sty ${INSTALL_PATH}
	@${ECHO} "Installing documentation ..."
	@${INSTALL} herm-pic-doc.* ${DOC_PATH}

test:
	@${ECHO} "Testing package ..."
	@cd test; make 

doc_clean:
	@${REMOVE} *.aux *.log *.toc *~
	@cd test; make doc_clean

clean:	doc_clean
	@${REMOVE} *.dvi *.ps *.pdf *.ps*
	@cd test; make clean

FORCE: ;

# Rule pattern
%.ps:	%.dvi FORCE
	${DVIPS} -o $@ $<

%.dvi:	%.tex
	${LATEX} $<

%.pdf:	%.tex
	${PDFLATEX} $<

.PHONY: test clean doc_clean all doc psdoc pdfdoc 
