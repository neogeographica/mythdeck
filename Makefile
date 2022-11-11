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

COPYDIR_BASE := $(notdir $(COPYDIR))

.PHONY: html copydocs clean copyclean

html:
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)

$(BUILDDIR)/html: html

copydocs: $(BUILDDIR)/html
	@if test -z "$(COPYDIR)"; then echo "gotta set COPYDIR!"; exit 1; fi
	@rm -rf "$(COPYDIR)"
	@mkdir -p "$(COPYDIR)"
	@cp -r "$(BUILDDIR)/html/"* "$(COPYDIR)/"
	@rm -f "$(COPYDIR)/objects.inv"
	@mv "$(COPYDIR)/mythdeck_readme.html" "$(COPYDIR)/../"
	@sed -i ${SEDSEPARATOR} \
		-e 's/<head>/<head><base href="$(COPYDIR_BASE)\/">/${SEDIGNORECASE}' \
		"$(COPYDIR)/../mythdeck_readme.html"
	@sed -i ${SEDSEPARATOR} \
		-e 's/href="#"/href="..\/mythdeck_readme.html#"/${SEDIGNORECASE}' \
		"$(COPYDIR)/../mythdeck_readme.html"
	@sed -i ${SEDSEPARATOR} \
		-e 's/mythdeck_readme.html">/..\/mythdeck_readme.html">/g' \
		"$(COPYDIR)/"*/*.html
	@sed -i ${SEDSEPARATOR} \
		-e 's/mythdeck_readme.html">/..\/mythdeck_readme.html">/g' \
		"$(COPYDIR)/"search*

clean:
	@$(SPHINXBUILD) -M clean "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)

copyclean:
	@if test -z "$(COPYDIR)"; then echo "gotta set COPYDIR!"; exit 1; fi
	@rm -rf "$(COPYDIR)/../mythdeck_readme.html" "$(COPYDIR)"