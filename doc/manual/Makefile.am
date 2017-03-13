NULL =

BOOK_NAME = vala@PACKAGE_SUFFIX@

bookdir = $(datadir)/devhelp/books/$(BOOK_NAME)

if HAVE_XSLTPROC
book_DATA = \
	devhelp/* \
	$(NULL)

$(builddir)/devhelp/*: devhelp
devhelp: manual.xml version.xml common.xsl devhelp.xsl xhtml.xsl default.css
	@$(MKDIR_P) $@
	$(AM_V_GEN)$(XSLTPROC) \
		--xinclude \
		--path $(srcdir) \
		--output $@/$(BOOK_NAME).devhelp2 \
		$(srcdir)/devhelp.xsl \
		$(srcdir)/manual.xml
	@$(XSLTPROC) \
		--xinclude \
		--path $(srcdir) \
		--output $@/index.html \
		$(srcdir)/xhtml.xsl \
		$(srcdir)/manual.xml
	@cp $(srcdir)/default.css $@
	@touch $@

html: manual.xml version.xml common.xsl xhtml.xsl default.css
	@$(MKDIR_P) $@
	$(AM_V_GEN)$(XSLTPROC) \
		--xinclude \
		--stringparam body-class u-center \
		--output $@/index.html \
		$(srcdir)/xhtml.xsl \
		$(srcdir)/manual.xml
	@cp $(srcdir)/default.css $@
	@touch $@

print: manual.html
manual.html: manual.xml version.xml common.xsl print.xsl default.css
	$(AM_V_GEN)$(XSLTPROC) \
		--xinclude \
		--path $(srcdir) \
		--output $@ \
		$(srcdir)/print.xsl \
		$(srcdir)/manual.xml

if HAVE_WEASYPRINT
pdf: manual.pdf
manual.pdf: manual.html default.css
	@echo Generating PDF version of manual, this may take some time...
	$(AM_V_GEN)$(WEASYPRINT) \
		manual.html \
		$@
else
pdf:
	@echo Install weasyprint and re-run ./configure to generate a PDF of the Vala manual
endif

endif

mostlyclean-local:
	rm -rf devhelp
	rm -rf html

CLEANFILES = \
	manual.html \
	manual.pdf \
	version.xml \
	$(NULL)

EXTRA_DIST = \
	common.xsl \
	default.css \
	devhelp.xsl \
	manual.xml \
	print.xsl \
	xhtml.xsl \
	README \
	$(NULL)

MANUAL_DOCBOOK_URL=https://wiki.gnome.org/Projects/Vala/Manual/Export?action=format\&mimetype=text/docbook

$(srcdir)/manual.xml:
	@echo "Generating $@ from $(MANUAL_DOCBOOK_URL)"
	@curl --silent $(MANUAL_DOCBOOK_URL) | \
		sed -e 's/<articleinfo>.*<\/articleinfo>//g' | \
		sed -e 's/<section>/\n\n<section>/g' | \
		sed -e 's/<\/section>/\n<\/section>/g' | \
		sed -e 's/<title>/\n<title>/g' | \
		sed -e 's/<para>/\n<para>/g' \
		> $@

update-manual-from-wiki:
	@rm $(srcdir)/manual.xml
	$(MAKE) $(AM_MAKEFLAGS) manual.xml
	$(MAKE) $(AM_MAKEFLAGS)

