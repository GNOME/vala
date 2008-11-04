# src/Makefile.am




libdoclet_VALASOURCES = \
	template.vala       \
	$(NULL)


BUILT_SOURCES = libdoclet.vala.stamp


libdoclet.vala.stamp: $(libdoclet_VALASOURCES)
	$(VALAC) -C --vapidir ../../htmlhelpers --pkg libhtmlhelpers-1.0 --vapidir ../../../vapi --pkg valadoc-1.0 --vapidir ../linkhelper --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

docletdir = $(libdir)/valadoc/plugins/valadoc.org/

doclet_LTLIBRARIES = libdoclet.la


libdoclet_la_SOURCES =                \
	libdoclet.vala.stamp              \
	$(libdoclet_VALASOURCES:.vala=.c) \
	$(libdoclet_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-I ../../../libvaladoc/   \
	-I ../../htmlhelpers/     \
	-I ../linkhelper/         \
	-I ../                    \
	$(GLIB_CFLAGS)            \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libdoclet_la_LDFLAGS = -module -avoid-version


libdoclet_la_LIBADD =                   \
	../../htmlhelpers/libhtmlhelpers.la \
	../../../libvaladoc/libvaladoc.la   \
	../linkhelper/libhtmlhelper.la      \
	$(GLIB_LIBS)                        \
	$(LIBVALA_LIBS)                     \
	$(NULL)




EXTRA_DIST = $(libdoclet_VALASOURCES)  libdoclet.vala.stamp 
