include $(top_srcdir)/Makefile.common

NULL =

AM_CFLAGS = \
	-DG_LOG_DOMAIN=\"valadoc\" \
	-DPACKAGE_VALADOC_LIBDIR=\"$(libdir)/valadoc@PACKAGE_SUFFIX@\" \
	-DPACKAGE_VERSION=\"$(VERSION)\" \
	$(COVERAGE_CFLAGS) \
	$(LIBGVC_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(GMODULE_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/ccode \
	-I$(top_srcdir)/vala \
	-I$(top_srcdir)/codegen \
	$(NULL)

AM_VALAFLAGS = \
	$(NULL)

BUILT_SOURCES = \
	libvaladoc.vala.stamp \
	valadoc.h \
	$(NULL)

lib_LTLIBRARIES = libvaladoc@PACKAGE_SUFFIX@.la

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
	gtkdocrenderer.vala \
	documentation/commentscanner.vala \
	documentation/documentation.vala \
	documentation/documentationparser.vala \
	documentation/wiki.vala \
	documentation/wikiscanner.vala \
	documentation/gtkdoccommentparser.vala \
	documentation/gtkdoccommentscanner.vala \
	documentation/gtkdocmarkdownparser.vala \
	documentation/gtkdocmarkdownscanner.vala \
	documentation/importerhelper.vala \
	documentation/girmetadata.vala \
	importer/documentationimporter.vala \
	importer/valadocdocumentationimporter.vala \
	importer/valadocdocumentationimporterscanner.vala \
	importer/girdocumentationimporter.vala \
	importer/internalidregistrar.vala \
	api/sourcecomment.vala \
	api/girsourcecomment.vala \
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
	api/interface.vala \
	api/item.vala \
	api/method.vala \
	api/namespace.vala \
	api/node.vala \
	api/nodetype.vala \
	api/ownership.vala \
	api/package.vala \
	api/parameter.vala \
	api/pointer.vala \
	api/property.vala \
	api/propertyaccessor.vala \
	api/signal.vala \
	api/signaturebuilder.vala \
	api/sourcefile.vala \
	api/struct.vala \
	api/symbol.vala \
	api/tree.vala \
	api/typeparameter.vala \
	api/typereference.vala \
	api/typesymbol.vala \
	api/visitor.vala \
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
	highlighter/scanner.vala \
	highlighter/codescanner.vala \
	highlighter/xmlscanner.vala \
	highlighter/codetoken.vala \
	highlighter/highlighter.vala \
	html/basicdoclet.vala \
	html/htmlchartfactory.vala \
	html/linkhelper.vala \
	html/cssclassresolver.vala \
	html/htmlmarkupwriter.vala \
	html/htmlrenderer.vala \
	$(NULL)

libvaladoc@PACKAGE_SUFFIX@_la_SOURCES = \
	libvaladoc.vala.stamp \
	$(libvaladoc_la_VALASOURCES:.vala=.c) \
	gvc-compat.c \
	$(NULL)

valadoc@PACKAGE_SUFFIX@.vapi valadoc.h: libvaladoc.vala.stamp
libvaladoc.vala.stamp: $(libvaladoc_la_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		--basedir $(srcdir) \
		--directory $(builddir) \
		-C \
		--use-header \
		-H valadoc.h \
		--library valadoc \
		--vapi valadoc@PACKAGE_SUFFIX@.vapi \
		--vapidir $(top_srcdir)/vapi --pkg gmodule-2.0 \
		--vapidir $(top_srcdir)/vapi --pkg libgvc \
		--vapidir $(top_srcdir)/gee --pkg gee \
		--vapidir $(top_srcdir)/vala --pkg vala \
		--vapidir $(top_srcdir)/ccode --pkg ccode \
		--vapidir $(top_srcdir)/codegen --pkg codegen \
		--pkg config \
		$(filter %.vala %.c,$^)
	touch $@

libvaladoc@PACKAGE_SUFFIX@_la_LDFLAGS = \
	-no-undefined \
	$(NULL)

libvaladoc@PACKAGE_SUFFIX@_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(LIBGVC_LIBS) \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	$(top_builddir)/vala/libvala@PACKAGE_SUFFIX@.la \
	$(top_builddir)/codegen/libvalaccodegen.la \
	$(NULL)

libvaladocincludedir = $(includedir)/valadoc@PACKAGE_SUFFIX@
libvaladocinclude_HEADERS = \
	valadoc.h \
	$(NULL)

pkgconfigdir = $(libdir)/pkgconfig
nodist_pkgconfig_DATA = valadoc@PACKAGE_SUFFIX@.pc

valadoc@PACKAGE_SUFFIX@.pc: valadoc.pc
	cp $< $@

vapidir = $(datadir)/vala/vapi
dist_vapi_DATA = valadoc@PACKAGE_SUFFIX@.vapi
nodist_vapi_DATA = valadoc@PACKAGE_SUFFIX@.deps

valadoc@PACKAGE_SUFFIX@.deps: valadoc.deps
	cp $< $@

EXTRA_DIST = \
	$(libvaladoc_la_VALASOURCES) \
	libvaladoc.vala.stamp \
	valadoc.deps.in \
	valadoc.pc.in \
	$(NULL)

CLEANFILES = \
	valadoc@PACKAGE_SUFFIX@.deps \
	valadoc@PACKAGE_SUFFIX@.pc \
	$(NULL)

MAINTAINERCLEANFILES = \
	valadoc.deps \
	valadoc.pc \
	valadoc.vapi \
	valadoc.h \
	$(libvaladoc_la_VALASOURCES:.vala=.c) \
	$(NULL)

