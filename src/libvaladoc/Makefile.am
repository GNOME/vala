NULL =


AM_CFLAGS =             \
	$(LIBGVC_CFLAGS)    \
	$(LIBXML2_CFLAGS)   \
	$(GLIB_CFLAGS)      \
	$(LIBGEE_CFLAGS)    \
	$(LIBVALA_CFLAGS)   \
	$(GMODULE_CFLAGS)   \
	$(NULL)


BUILT_SOURCES = libvaladoc.vala.stamp


valadoc_LTLIBRARIES = \
	libvaladoc.la     \
	$(NULL)

valadocdir = $(libdir)/valadoc/


libvaladoc_la_VALASOURCES = \
	doclet.vala \
	drawer.vala \
	errorreporter.vala \
	filehelper.vala \
	moduleloader.vala \
	settings.vala \
	documentation/commentscanner.vala \
	documentation/documentation.vala \
	documentation/documentationparser.vala \
	documentation/wiki.vala \
	documentation/wikiscanner.vala \
	apitree/apiitem.vala \
	apitree/apimembernode.vala \
	apitree/apinode.vala \
	apitree/apinodebuilder.vala \
	apitree/apisymbolnode.vala \
	apitree/apitree.vala \
	apitree/apitypesymbolnode.vala \
	apitree/array.vala \
	apitree/class.vala \
	apitree/classhandler.vala \
	apitree/constant.vala \
	apitree/constanthandler.vala \
	apitree/constructionmethodhandler.vala \
	apitree/delegate.vala \
	apitree/delegatehandler.vala \
	apitree/enum.vala \
	apitree/enumhandler.vala \
	apitree/enumvalue.vala \
	apitree/errorcode.vala \
	apitree/errordomain.vala \
	apitree/errordomainhandler.vala \
	apitree/exceptionlisthandler.vala \
	apitree/field.vala \
	apitree/fieldhandler.vala \
	apitree/formalparameter.vala \
	apitree/interface.vala \
	apitree/interfacehandler.vala \
	apitree/method.vala \
	apitree/methodhandler.vala \
	apitree/namespace.vala \
	apitree/namespacehandler.vala \
	apitree/package.vala \
	apitree/parameterlisthandler.vala \
	apitree/pointer.vala \
	apitree/property.vala \
	apitree/propertyaccessor.vala \
	apitree/propertyhandler.vala \
	apitree/returntypehandler.vala \
	apitree/signal.vala \
	apitree/signalhandler.vala \
	apitree/signaturebuilder.vala \
	apitree/struct.vala \
	apitree/structhandler.vala \
	apitree/symbolaccessibility.vala \
	apitree/templateparameterlisthandler.vala \
	apitree/typeparameter.vala \
	apitree/typereference.vala \
	apitree/visitable.vala \
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
	$(VALAC) $(VALAFLAGS) -C -H valadoc-1.0.h --pkg gee-1.0 --pkg vala-1.0 --pkg gmodule-2.0 --vapidir ../vapi --pkg libxml-2.0 --pkg libgvc --library valadoc-1.0 --basedir $(top_srcdir)/src/libvaladoc/ --save-temps $^
	touch $@


libvaladoc_la_LIBADD = \
	$(LIBGVC_LIBS)     \
	$(LIBXML2_LIBS)    \
	$(LIBGEE_LIBS)     \
	$(GLIB_LIBS)       \
	$(LIBVALA_LIBS)    \
	$(GMODULE_LIBS)    \
	$(NULL)


EXTRA_DIST = $(libvaladoc_la_VALASOURCES)  libvaladoc.vala.stamp


MAINTAINERCLEANFILES =                    \
	valadoc-1.0.vapi                      \
	valadoc-1.0.h                         \
	valadoc-1.0.gir                       \
	$(libvaladoc_la_VALASOURCES:.vala=.c) \
	$(NULL)

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = valadoc-1.0.pc

