# src/Makefile.am




libdoclet_VALASOURCES = \
	template.vala       \
	$(NULL)


BUILT_SOURCES = libdoclet.vala.stamp


libdoclet.vala.stamp: $(libdoclet_VALASOURCES)
	$(VALAC) -C --vapidir ../../htmlhelpers --pkg libhtmlhelpers-1.0 --vapidir ../../../vapi --pkg valadoc-1.0 --vapidir ../linkhelper --pkg libxml-2.0 --pkg libhtmlhelper-1.0 --vapidir . --pkg docletconfig --basedir . --save-temps $^
	touch $@


	

docletdir = $(libdir)/valadoc/plugins/devhelp/

doclet_LTLIBRARIES = libdoclet.la


libdoclet_la_SOURCES =                \
	libdoclet.vala.stamp              \
	$(libdoclet_VALASOURCES:.vala=.c) \
	$(libdoclet_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-DPACKAGE_PLUGINDIR=\"$(libdir)/valadoc/plugins/devhelp/\" \
	-I ../../../libvaladoc/   \
	-I ../../htmlhelpers/     \
	-I ../linkhelper/         \
	-I ../                    \
	$(GLIB_CFLAGS)            \
	$(LIBXML2_CFLAGS)         \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libdoclet_la_LDFLAGS = -module -avoid-version


libdoclet_la_LIBADD =                   \
	../../../libvaladoc/libvaladoc.la   \
	../../htmlhelpers/libhtmlhelpers.la \
	../linkhelper/libhtmlhelper.la      \
	$(LIBXML2_LIBS)                     \
	$(GLIB_LIBS)                        \
	$(LIBVALA_LIBS)                     \
	$(NULL)




EXTRA_DIST = $(libdoclet_VALASOURCES)  libdoclet.vala.stamp 
