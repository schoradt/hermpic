#############################################################
# Makefile for the installation of the herm-pic latex       #
# package.                                                  #
#                                                           #
# Prepared for the debian packaging system.                 #
#                                                           #
# Version: 0.2                                              #
# Author: Sven Schoradt <schoradt@informatik.tu-cottbus.de> #
#############################################################

# Include configuration file
include Makefile.config

# directories
DESTDIR = 

# path to install the latex packages
INSTALL_PATH = $(DESTDIR)/usr/share/texmf/tex/latex/herm-pic

#path to install the documentation
DOC_PATH = $(DESTDIR)/usr/share/doc/hermpic

#############################################################

all:

doc: psdoc pdfdoc

psdoc: herm-pic-doc.ps

pdfdoc: herm-pic-doc.pdf

install: Makefile.config herm-pic.sty doc_clean
	@echo "Installing package ..."
	@${INSTALL} herm-pic.sty ${INSTALL_PATH}
	@echo "Installing documentation ..."
	@${INSTALL} herm-pic-doc.* ${DOC_PATH}

test:
	@echo "Testing package ..."
	@cd test; make 

doc_clean:
	@rm -f *.aux *.log *.toc *~
	@cd test; make doc_clean

clean:	doc_clean
	@rm -f *.dvi *.ps *.pdf *.ps*
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
