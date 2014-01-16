NULL =

DEFAULT_DRIVER = "`$(VALAC) --api-version >& /dev/null; if [ $$? = 0 ]; then $(VALAC) --api-version; else $(VALAC) --version; fi`"

AM_CFLAGS = \
	-DPACKAGE_ICONDIR=\"$(datadir)/valadoc/icons/\" \
	-DPACKAGE_DATADIR=\"$(libdir)/valadoc\" \
	-DPACKAGE_VERSION=\"$(VERSION)\" \
	-DDEFAULT_DRIVER=\"$(DEFAULT_DRIVER)\" \
	$(LIBGVC_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(LIBGEE_CFLAGS) \
	$(GMODULE_CFLAGS) \
	-g \
	-w \
	$(NULL)

AM_VALAFLAGS = \
	$(VALAFLAGS) \
	--vapidir $(top_srcdir)/src/vapi/ \
	--basedir $(srcdir) \
	--directory $(builddir) \
	-C \
	-g \
	$(NULL)

BUILT_SOURCES = \
	libvaladoc.vala.stamp \
	valadoc-1.0.h \
	$(NULL)

lib_LTLIBRARIES = libvaladoc.la

libvaladoc_la_VALASOURCES = \
	doclet.vala \
	errorreporter.vala \
	filehelper.vala \
	moduleloader.vala \
	settings.vala \
	markupwriter.vala \
	gtkdocmarkupwriter.vala \
	devhelp-markupwriter.vala \
	ctyperesolver.vala \
	markupsourcelocation.vala \
	markuptokentype.vala \
	markupreader.vala \
	gtkdocrenderer.vala \
	documentation/commentscanner.vala \
	documentation/documentation.vala \
	documentation/documentationparser.vala \
	documentation/wiki.vala \
	documentation/wikiscanner.vala \
	documentation/gtkdoccommentparser.vala \
	documentation/gtkdoccommentscanner.vala \
	documentation/girmetadata.vala \
	importer/documentationimporter.vala \
	importer/valadocdocumentationimporter.vala \
	importer/valadocdocumentationimporterscanner.vala \
	importer/girdocumentationimporter.vala \
	api/symbolaccessibility.vala \
	api/sourcecomment.vala \
	api/girsourcecomment.vala \
	api/attributeargument.vala \
	api/attribute.vala \
	api/array.vala \
	api/callable.vala \
	api/childsymbolregistrar.vala \
	api/class.vala \
	api/constant.vala \
	api/delegate.vala \
	api/enum.vala \
	api/enumvalue.vala \
	api/errorcode.vala \
	api/errordomain.vala \
	api/field.vala \
	api/formalparameter.vala \
	api/formalparametertype.vala \
	api/interface.vala \
	api/item.vala \
	api/member.vala \
	api/method.vala \
	api/methodbindingtype.vala \
	api/namespace.vala \
	api/node.vala \
	api/nodetype.vala \
	api/ownership.vala \
	api/package.vala \
	api/pointer.vala \
	api/property.vala \
	api/propertyaccessor.vala \
	api/propertyaccessortype.vala \
	api/propertybindingtype.vala \
	api/signal.vala \
	api/signaturebuilder.vala \
	api/sourcefile.vala \
	api/struct.vala \
	api/symbol.vala \
	api/tree.vala \
	api/typeparameter.vala \
	api/typereference.vala \
	api/typesymbol.vala \
	api/browsable.vala \
	api/visitor.vala \
	api/driver.vala \
	content/block.vala \
	content/blockcontent.vala \
	content/comment.vala \
	content/contentfactory.vala \
	content/contentelement.vala \
	content/contentrenderer.vala \
	content/contentvisitor.vala \
	content/embedded.vala \
	content/headline.vala \
	content/inline.vala \
	content/inlinetaglet.vala \
	content/inlinecontent.vala \
	content/wikilink.vala \
	content/link.vala \
	content/list.vala \
	content/listitem.vala \
	content/page.vala \
	content/paragraph.vala \
	content/warning.vala \
	content/note.vala \
	content/resourcelocator.vala \
	content/run.vala \
	content/sourcecode.vala \
	content/styleattributes.vala \
	content/symbollink.vala \
	content/table.vala \
	content/tablecell.vala \
	content/tablerow.vala \
	content/taglet.vala \
	content/text.vala \
	charts/chart.vala \
	charts/chartfactory.vala \
	charts/hierarchychart.vala \
	charts/simplechartfactory.vala \
	parser/manyrule.vala \
	parser/oneofrule.vala \
	parser/optionalrule.vala \
	parser/parser.vala \
	parser/parsercallback.vala \
	parser/rule.vala \
	parser/scanner.vala \
	parser/sequencerule.vala \
	parser/sourcelocation.vala \
	parser/stubrule.vala \
	parser/token.vala \
	parser/tokentype.vala \
	taglets/tagletdeprecated.vala \
	taglets/tagletinheritdoc.vala \
	taglets/tagletinit.vala \
	taglets/tagletlink.vala \
	taglets/tagletparam.vala \
	taglets/tagletreturn.vala \
	taglets/tagletsee.vala \
	taglets/tagletsince.vala \
	taglets/tagletthrows.vala \
	html/basicdoclet.vala \
	html/htmlchartfactory.vala \
	html/linkhelper.vala \
	html/cssclassresolver.vala \
	html/htmlmarkupwriter.vala \
	html/htmlrenderer.vala \
	$(NULL)

nodist_libvaladoc_la_SOURCES = \
	$(libvaladoc_la_VALASOURCES:.vala=.c) \
	$(NULL)

valadoc-1.0.vapi valadoc-1.0.h: libvaladoc.vala.stamp
libvaladoc.vala.stamp: $(libvaladoc_la_VALASOURCES) Makefile
	$(VALAC) \
		$(AM_VALAFLAGS) \
		-H valadoc-1.0.h \
		--library valadoc-1.0 \
		--vapi valadoc-1.0.vapi \
		--pkg config \
		--pkg gee-0.8 \
		--pkg gmodule-2.0 \
		--pkg libgvc \
		$(filter %.vala %.c,$^)
	touch $@

libvaladoc_la_LDFLAGS = -no-undefined

libvaladoc_la_LIBADD = \
	$(LIBGVC_LIBS) \
	$(LIBGEE_LIBS) \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	$(NULL)

libvaladocincludedir = $(includedir)/
nodist_libvaladocinclude_HEADERS = \
	valadoc-1.0.h           \
	$(NULL)

pkgconfigdir = $(libdir)/pkgconfig
nodist_pkgconfig_DATA = valadoc-1.0.pc

vapidir = $(datadir)/vala/vapi
nodist_vapi_DATA = \
	valadoc-1.0.vapi \
	valadoc-1.0.deps \
	$(NULL)

EXTRA_DIST = \
	$(libvaladoc_la_VALASOURCES) \
	valadoc-1.0.deps.in \
	valadoc-1.0.pc.in \
	$(NULL)

CLEANFILES = \
	$(BUILT_SOURCES) \
	$(nodist_libvaladoc_la_SOURCES) \
	valadoc-1.0.deps \
	valadoc-1.0.pc \
	valadoc-1.0.vapi \
	valadoc-1.0.h \
	$(NULL)

