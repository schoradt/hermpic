#############################################################
# Makefile for the instalation of the herm-pic latex        #
# package.                                                  #
#                                                           #
# Version: 0.1                                              #
# Author: Sven Schoradt <schoradt@informatik.tu-cottbus.de> #
#############################################################

DATE := $(shell date +%Y_%m_%e)

CVSROOT = :pserver:sven@cvs.dex.de:/var/cvs
CVSPATH = schoradt/tex

VERSION := 0_5

# Include configuration file
include Makefile.config

#############################################################

help:
	@echo "       Instalation of the LaTex herm-pic package"
	@echo "      -------------------------------------------"
	@echo ""
	@echo "Step 1: Configure the installation process by make config"
	@echo "Step 2: Build the documentation by make doc, make psdoc or make pdfdoc"
	@echo "Step 3: Install the package by make install"
	@echo ""

config: Makefile.config
	@${EDITOR} $<
	@echo "Now make documentation or install the package without documentation."

doc: psdoc pdfdoc

psdoc: herm-pic-doc.ps

pdfdoc: herm-pic-doc.pdf

install: Makefile.config herm-pic.sty doc_clean
	@echo "Installing package ..."
	@mkdir -p ${INSTALL_PATH}
	@${INSTALL} herm-pic.sty ${INSTALL_PATH}
	@echo "Installing documentation ..."
	@mkdir -p ${DOC_PATH}
	@${INSTALL} herm-pic-doc.* ${DOC_PATH}

test: hermtest.ps 

doc_clean:
	@rm -f *.aux *.log *.toc *.bbl *.blg *~

clean:	doc_clean dist_clean
	@rm -f *.dvi *.ps *.pdf *.ps*

FORCE: ;

dist_clean:
	@rm -rf .dist

dist_prepare: dist_clean
	@echo "Prepare distributing herm-pic ..."
	@mkdir .dist
	@cd .dist; mkdir herm-pic_$(VERSION)
	@cd .dist; cvs -d $(CVSROOT) export -D now $(CVSPATH)
	@mv .dist/$(CVSPATH)/* .dist/herm-pic_$(VERSION)
        

dist: dist_prepare
	@cd .dist; tar -czf ../herm-pic_$(VERSION)_${DATE}.tar.gz herm-pic_$(VERSION)

# Rule pattern
%.ps:	%.dvi FORCE
	${DVIPS} -o $@ $<

%.dvi:	%.tex
	${LATEX} $<

%.pdf:	%.tex
	${PDFLATEX} $<
