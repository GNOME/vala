#src/Makefile.am


libdoclet_VALASOURCES = \
	xmlmarkupwriter.vala \
	xmlrenderer.vala \
	doclet.vala \
	$(NULL)


BUILT_SOURCES = libdoclet.vala.stamp


libdoclet.vala.stamp: $(libdoclet_VALASOURCES)
	$(VALAC) -C --vapidir $(top_srcdir)/src/vapi/ --vapidir $(top_srcdir)/src/libvaladoc --pkg valadoc-1.0 --pkg vala-1.0 --pkg gee-1.0 --basedir . --save-temps $^
	touch $@


docletdir = $(libdir)/valadoc/plugins/xml


doclet_LTLIBRARIES = libdoclet.la


libdoclet_la_SOURCES = \
	libdoclet.vala.stamp \
	$(libdoclet_VALASOURCES:.vala=.c) \
	$(libdoclet_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g \
	-DPACKAGE_ICONDIR=\"$(datadir)/valadoc/icons/\" \
	-I ../../libvaladoc/ \
	$(GLIB_CFLAGS) \
	$(LIBGEE_CFLAGS) \
	$(LIBVALA_CFLAGS) \
	$(NULL)


libdoclet_la_LDFLAGS = -module -avoid-version -no-undefined


libdoclet_la_LIBADD = \
	../../libvaladoc/libvaladoc.la \
	$(GLIB_LIBS)  \
	$(LIBGEE_LIBS) \
	$(LIBVALA_LIBS) \
	$(NULL)


EXTRA_DIST = $(libdoclet_VALASOURCES)  libdoclet.vala.stamp 


MAINTAINERCLEANFILES = \
	$(libdoclet_la_SOURCES) \
	$(NULL)

