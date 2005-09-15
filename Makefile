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
MKDIR = mkdir
COPY = cp

INSTALL = install -m 644

LATEX = latex
DVIPS = dvips

PDFLATEX = pdflatex

# directories
DESTDIR = 

# path to install the latex packages
SYS_INSTALL_PATH = $(DESTDIR)/usr/share/texmf/tex/latex/herm-pic
HOME_INSTALL_PATH = $(DESTDIR)$(HOME)/texmf/tex/latex

#path to install the documentation
SYS_DOC_PATH = $(DESTDIR)/usr/share/doc/hermpic
HOME_DOC_PATH = $(DESTDIR)$(HOME)/doc

all:

doc: psdoc pdfdoc

psdoc: herm-pic-doc.ps herm-pic-erd-doc.ps

pdfdoc: herm-pic-doc.pdf herm-pic-erd-doc.pdf

sysinstall:  herm-pic.sty herm-rev.sty herm-pic-impl.sty  herm-pic-old.sty doc doc_clean
	@${ECHO} "Installing package ..."
	@${INSTALL} herm-pic.sty ${SYS_INSTALL_PATH}
	@${INSTALL} herm-rev.sty ${SYS_INSTALL_PATH}
	@${INSTALL} herm-pic-impl.sty ${SYS_INSTALL_PATH}
	@${INSTALL} herm-pic-old.sty ${SYS_INSTALL_PATH}
	@${ECHO} "Installing documentation ..."
	@${INSTALL} herm-pic-doc.ps ${SYS_DOC_PATH}
	@${INSTALL} herm-pic-doc.pdf ${SYS_DOC_PATH}
	@${INSTALL} herm-pic-erd-doc.ps ${SYS_DOC_PATH}
	@${INSTALL} herm-pic-erd-doc.pdf ${SYS_DOC_PATH}


homeinstall:  herm-pic.sty herm-rev.sty herm-pic-impl.sty  herm-pic-old.sty doc doc_clean
	@${ECHO} "Installing package ..."
	@${INSTALL} herm-pic.sty ${HOME_INSTALL_PATH}
	@${INSTALL} herm-rev.sty ${HOME_INSTALL_PATH}
	@${INSTALL} herm-pic-impl.sty ${HOME_INSTALL_PATH}
	@${INSTALL} herm-pic-old.sty ${HOME_INSTALL_PATH}
	@${ECHO} "Installing documentation ..."
	@${INSTALL} herm-pic-doc.ps ${HOME_DOC_PATH}
	@${INSTALL} herm-pic-doc.pdf ${HOME_DOC_PATH}
	@${INSTALL} herm-pic-erd-doc.ps ${SYS_DOC_PATH}
	@${INSTALL} herm-pic-erd-doc.pdf ${SYS_DOC_PATH}

test:
	@${ECHO} "Testing package ..."
	@cd test; make
	@${ECHO} "see under test/ for genereated test_*.ps files"

create_examples: examples
	@${COPY} test/test_*.tex examples/
	@rename 's/test/example/' examples/test_*

examples:
	@${ECHO} "Create example dir ... "
	@${MKDIR} $@

doc_clean:
	@${REMOVE} *.aux *.log *.toc *~
	@cd test; make doc_clean

example_clean:
	@${REMOVE} -rf examples

clean:	doc_clean example_clean
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

.PHONY: test clean doc_clean all doc psdoc pdfdoc create_examples
