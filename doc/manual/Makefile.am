NULL =

manual_SOURCE = \
	source/_static/bullet.svg \
	source/_static/fonts \
	source/_static/fonts/cantarell-bold-latin.woff2 \
	source/_static/fonts/cantarell-extra-bold-latin.woff2 \
	source/_static/fonts/cantarell-light.woff2 \
	source/_static/fonts/cantarell-regular-latin.woff2 \
	source/_static/gnome.css \
	source/_static/right.svg \
	source/_static/toc_bullet.svg \
	source/_templates/page.html \
	source/_templates/sidebar/brand.html \
	source/attributes.rst \
	source/classes.rst \
	source/concepts.rst \
	source/conf.py \
	source/delegates.rst \
	source/enumerated-types-enums.rst \
	source/errors.rst \
	source/expressions.rst \
	source/generics.rst \
	source/gidl-metadata-format.rst \
	source/gir-metadata-format.rst \
	source/index.rst \
	source/interfaces.rst \
	source/logo.png \
	source/methods.rst \
	source/namespaces.rst \
	source/overview.rst \
	source/preprocessor.rst \
	source/statements.rst \
	source/structs.rst \
	source/types.rst \
	$(NULL)

if HAVE_SPHINXBUILD
.PHONY: html devhelp
html: $(manual_SOURCE)
	VERSION=$(VERSION) $(SPHINXBUILD) -M html $(srcdir)/source $(builddir)/build

devhelp: $(manual_SOURCE)
	VERSION=$(VERSION) $(SPHINXBUILD) -M devhelp $(srcdir)/source $(builddir)/build

if HAVE_LATEXMK
.PHONY: pdf
pdf: manual.pdf
manual.pdf: $(manual_SOURCE)
	VERSION=$(VERSION) $(SPHINXBUILD) -M latexpdf $(srcdir)/source $(builddir)/build
	mv -f $(builddir)/build/latex/valareferencemanual.pdf $@

manualdir = $(docdir)@PACKAGE_SUFFIX@
dist_manual_DATA = \
	manual.pdf \
	$(NULL)
else
	@echo Install latexmk and re-run ./configure to generate the Vala manual PDF
endif
else
	@echo Install sphinx-build and re-run ./configure to generate the Vala manual
endif

distclean-local:
	rm -rf $(builddir)/build

EXTRA_DIST = \
	$(manual_SOURCE) \
	README.md \
	$(NULL)

MAINTAINERCLEANFILES = \
	build \
	$(NULL)

CLEANFILES = \
	$(NULL)
