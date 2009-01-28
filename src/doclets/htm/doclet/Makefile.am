# src/Makefile.am




libdoclet_VALASOURCES = \
	template.vala       \
	$(NULL)


BUILT_SOURCES = libdoclet.vala.stamp


libdoclet.vala.stamp: $(libdoclet_VALASOURCES)
	$(VALAC) -C --vapidir ../../htmlhelpers --pkg libhtmlhelpers-1.0 --vapidir ../../../vapi --pkg valadoc-1.0 --pkg libxml-2.0 --vapidir . --pkg docletconfig --basedir . $^
	touch $@


	

docletdir = $(libdir)/valadoc/plugins/html/

doclet_LTLIBRARIES = libdoclet.la


libdoclet_la_SOURCES =                \
	libdoclet.vala.stamp              \
	$(libdoclet_VALASOURCES:.vala=.c) \
	$(libdoclet_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-DPACKAGE_PLUGINDIR=\"$(libdir)/valadoc/plugins/html/\" \
	-I ../../../libvaladoc/   \
	-I ../../htmlhelpers/     \
	-I ../                    \
	$(GLIB_CFLAGS)            \
	$(LIBXML2_CFLAGS)         \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libdoclet_la_LDFLAGS = -module -avoid-version


libdoclet_la_LIBADD =                   \
	../../../libvaladoc/libvaladoc.la   \
	../../htmlhelpers/libhtmlhelpers.la \
	$(LIBXML2_LIBS)                     \
	$(GLIB_LIBS)                        \
	$(LIBVALA_LIBS)                     \
	$(NULL)




EXTRA_DIST = $(libdoclet_VALASOURCES)  libdoclet.vala.stamp 
