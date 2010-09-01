NULL =

globalvapidir = `pkg-config $(VALA_PACKAGE) --variable vapidir`


AM_CFLAGS = \
	-DPACKAGE_ICONDIR=\"$(datadir)/valadoc/icons/\" \
	-DPACKAGE_VAPIDIR=\"$(globalvapidir)\" \
	$(LIBGVC_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(LIBGEE_CFLAGS) \
	$(LIBVALA_CFLAGS) \
	$(GMODULE_CFLAGS) \
	$(NULL)


BUILT_SOURCES = libvaladoc.vala.stamp


lib_LTLIBRARIES = \
	libvaladoc.la     \
	$(NULL)


libvaladoc_la_VALASOURCES = \
	doclet.vala \
	errorreporter.vala \
	filehelper.vala \
	moduleloader.vala \
	settings.vala \
	markupwriter.vala \
	devhelp-markupwriter.vala \
	ctyperesolver.vala \
	documentation/girdocumentationscanner.vala \
	documentation/commentscanner.vala \
	documentation/documentation.vala \
	documentation/documentationparser.vala \
	documentation/wiki.vala \
	documentation/wikiscanner.vala \
	importer/girdocumentationimporter.vala \
	importer/documentationimporter.vala \
	importer/girdocumentationbuilder.vala \
	importer/valadocdocumentationimporter.vala \
	importer/valadocdocumentationimporterscanner.vala \
	api/array.vala \
	api/class.vala \
	api/constant.vala \
	api/delegate.vala \
	api/enum.vala \
	api/enumvalue.vala \
	api/errorcode.vala \
	api/errordomain.vala \
	api/field.vala \
	api/formalparameter.vala \
	api/interface.vala \
	api/item.vala \
	api/member.vala \
	api/method.vala \
	api/namespace.vala \
	api/node.vala \
	api/nodebuilder.vala \
	api/package.vala \
	api/pointer.vala \
	api/property.vala \
	api/propertyaccessor.vala \
	api/signal.vala \
	api/signaturebuilder.vala \
	api/struct.vala \
	api/symbol.vala \
	api/tree.vala \
	api/typeparameter.vala \
	api/typereference.vala \
	api/typesymbol.vala \
	api/browsable.vala \
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
	content/link.vala \
	content/list.vala \
	content/listitem.vala \
	content/page.vala \
	content/paragraph.vala \
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


libvaladoc_la_SOURCES =                \
	libvaladoc.vala.stamp              \
	$(libvaladoc_la_VALASOURCES:.vala=.c) \
	$(NULL)


libvaladocinclude_HEADERS = \
	valadoc-1.0.h           \
	$(NULL)


libvaladocincludedir = $(includedir)/


libvaladoc.vala.stamp: $(libvaladoc_la_VALASOURCES)
	$(VALAC) $(VALAFLAGS) -C -H valadoc-1.0.h --pkg gee-1.0 --pkg $(VALA_PACKAGE) --pkg libgvc --pkg gmodule-2.0 --pkg libgvc --vapidir $(top_srcdir)/src/vapi --pkg config --library valadoc-1.0 --basedir $(top_srcdir)/src/libvaladoc/ --save-temps $^
	touch $@


libvaladoc_la_LDFLAGS = -no-undefined


libvaladoc_la_LIBADD = \
	$(LIBGVC_LIBS)     \
	$(LIBGEE_LIBS)     \
	$(GLIB_LIBS)       \
	$(LIBVALA_LIBS)    \
	$(GMODULE_LIBS)    \
	$(NULL)


EXTRA_DIST =                         \
	$(libvaladoc_la_VALASOURCES) \
	libvaladoc.vala.stamp        \
	valadoc-1.0.vapi             \
	valadoc-1.0.deps             \
	$(NULL)


MAINTAINERCLEANFILES =                        \
	valadoc-1.0.vapi                      \
	valadoc-1.0.h                         \
	valadoc-1.0.gir                       \
	$(libvaladoc_la_VALASOURCES:.vala=.c) \
	$(NULL)

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = valadoc-1.0.pc

valadoc-1.0.deps: valadoc-1.0.deps.in
	cat $^ > $@
	echo $(VALA_PACKAGE) >> $@

vapidir = $(datadir)/vala/vapi
vapi_DATA =     \
	valadoc-1.0.vapi \
	valadoc-1.0.deps \
	$(NULL)


