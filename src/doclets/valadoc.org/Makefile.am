#src/Makefile.am


libdoclet_VALASOURCES = \
	doclet.vala \
	wikirenderer.vala \
	$(NULL)


BUILT_SOURCES = libdoclet.vala.stamp


libdoclet.vala.stamp: $(libdoclet_VALASOURCES)
	$(VALAC) -C --vapidir ../../libvaladoc/ --vapidir ../../vapi/ --pkg valadoc-1.0 --pkg gee-1.0 --basedir . --save-temps $^
	touch $@


docletdir = $(libdir)/valadoc/plugins/valadoc.org/


doclet_LTLIBRARIES = libdoclet.la


libdoclet_la_SOURCES = \
	libdoclet.vala.stamp \
	$(libdoclet_VALASOURCES:.vala=.c) \
	$(libdoclet_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g \
	-I ../../libvaladoc/ \
	$(GLIB_CFLAGS) \
	$(LIBGEE_CFLAGS) \
	$(LIBVALA_CFLAGS) \
	$(NULL)


libdoclet_la_LDFLAGS = -module -avoid-version \
	$(NULL)


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

