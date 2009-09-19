NULL =


AM_CFLAGS =             \
	$(LIBGVC_CFLAGS)    \
	$(LIBXML2_CFLAGS)   \
	$(GLIB_CFLAGS)      \
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
	filehelper.vala \
	langlet.vala \
	settings.vala \
	documentation/doctree.vala \
	documentation/errorreporter.vala \
	documentation/moduleloader.vala \
	documentation/parser.vala \
	documentation/wiki.vala \
	apitree/apitree.vala \
	apitree/array.vala \
	apitree/basic.vala \
	apitree/class.vala \
	apitree/classhandler.vala \
	apitree/constant.vala \
	apitree/constanthandler.vala \
	apitree/constructionmethodhandler.vala \
	apitree/delegate.vala \
	apitree/delegatehandler.vala \
	apitree/documentedelement.vala \
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
	apitree/struct.vala \
	apitree/structhandler.vala \
	apitree/symbolaccessibility.vala \
	apitree/templateparameterlisthandler.vala \
	apitree/typeparameter.vala \
	apitree/typereference.vala \
	apitree/visitable.vala \
	html/attribute.vala \
	html/block.vala \
	html/htmlwriter.vala \
	html/inline.vala \
	html-apiwriter/apiwriter.vala \
	html-apiwriter/apiwriter-vala.vala \
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
	$(VALAC) -C -H valadoc-1.0.h --pkg vala-1.0 --pkg gmodule-2.0 --vapidir ../vapi --pkg libxml-2.0 --pkg libgvc --library valadoc-1.0 --basedir $(top_srcdir)/src/libvaladoc/ --save-temps $^
	touch $@


libvaladoc_la_LIBADD = \
	$(LIBGVC_LIBS)     \
	$(LIBXML2_LIBS)    \
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

