THIS_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

SPHINXOPTS    :=
SPHINXBUILD   := sphinx-build
SPHINXPROJ    := MythDeck
SOURCEDIR     := .
BUILDDIR      := _build

UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
SEDSEPARATOR =
SEDIGNORECASE = 'I'
else
SEDSEPARATOR = ''
SEDIGNORECASE =
endif

.PHONY: html clean

html:
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)

$(BUILDDIR)/html: html

clean:
	@$(SPHINXBUILD) -M clean "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)
