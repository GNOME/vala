NULL =

bookdir=$(datadir)/devhelp/books/vala

chapter_data = \
	overview.html \
	types.html \
	expressions.html \
	statements.html \
	namespaces.html \
	methods.html \
	classes.html \
	structs.html \
	interfaces.html \
	enums.html \
	delegates.html \
	exceptions.html \
	attributes.html \
	$(NULL)

built_data = \
	index.html \
	$(chapter_data) \
	vala.devhelp2 \
	$(NULL)

if HAVE_XSLTPROC
book_DATA = \
	$(built_data) \
	default.css \
	$(NULL)
endif

index.html: $(book_sources) xhtml.xsl
	$(AM_V_GEN)$(XSLTPROC) --xinclude $(srcdir)/xhtml.xsl $(srcdir)/index.xml > index.html

$(chapter_data): index.html

vala.devhelp2: $(book_sources) devhelp.xsl
	$(AM_V_GEN)$(XSLTPROC) --xinclude $(srcdir)/devhelp.xsl $(srcdir)/index.xml > vala.devhelp2

book_sources = \
	index.xml \
	overview.xml \
	types.xml \
	expressions.xml \
	statements.xml \
	namespaces.xml \
	methods.xml \
	classes.xml \
	structs.xml \
	interfaces.xml \
	enums.xml \
	delegates.xml \
	exceptions.xml \
	attributes.xml \
	$(NULL)

MOSTLYCLEANFILES = $(built_data)

EXTRA_DIST = \
	$(book_sources) \
	default.css \
	xhtml.xsl \
	devhelp.xsl \
	$(NULL)

