NULL =

BOOK_NAME = vala@PACKAGE_SUFFIX@

bookdir = $(datadir)/devhelp/books/$(BOOK_NAME)

if HAVE_XSLTPROC
book_DATA = \
	devhelp/* \
	$(NULL)
endif

$(builddir)/devhelp/*: devhelp
devhelp: manual.xml version.xml devhelp.xsl xhtml.xsl default.css
	@$(MKDIR_P) $@
	$(AM_V_GEN)$(XSLTPROC) \
		--xinclude \
		--output $@/$(BOOK_NAME).devhelp2 \
		$(srcdir)/devhelp.xsl \
		$(srcdir)/manual.xml
	@$(XSLTPROC) \
		--xinclude \
		--output $@/index.html \
		$(srcdir)/xhtml.xsl \
		$(srcdir)/manual.xml
	@cp $(srcdir)/default.css $@
	@touch $@

html: manual.xml version.xml xhtml.xsl default.css
	@$(MKDIR_P) $@
	$(AM_V_GEN)$(XSLTPROC) \
		--xinclude \
		--output $@/index.html \
		$(srcdir)/xhtml.xsl \
		$(srcdir)/manual.xml
	@cp $(srcdir)/default.css $@
	@touch $@

mostlyclean-local:
	rm -rf devhelp
	rm -rf html

CLEANFILES = \
	version.xml \
	$(NULL)

EXTRA_DIST = \
	common.xsl \
	default.css \
	devhelp.xsl \
	manual.xml \
	xhtml.xsl \
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

