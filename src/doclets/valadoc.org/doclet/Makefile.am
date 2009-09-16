# src/Makefile.am


libdoclet_VALASOURCES = \
	doclet.vala \
	$(NULL)


BUILT_SOURCES = libdoclet.vala.stamp


libdoclet.vala.stamp: $(libdoclet_VALASOURCES)
	$(VALAC) -C --vapidir ../../htmlhelpers/languages/ --pkg apiwriter-1.0 --vapidir ../../../vapi/ --pkg valadoc-1.0 --basedir . --save-temps $^
	touch $@


	

docletdir = $(libdir)/valadoc/plugins/valadoc.org/


doclet_LTLIBRARIES = libdoclet.la


libdoclet_la_SOURCES =                \
	libdoclet.vala.stamp              \
	$(libdoclet_VALASOURCES:.vala=.c) \
	$(libdoclet_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                    \
	-I ../../../libvaladoc/        \
	-I ../../htmlhelpers/languages \
	`mysql_config --cflags`        \
	$(GLIB_CFLAGS)                 \
	$(LIBVALA_CFLAGS)              \
	$(NULL)


libdoclet_la_LDFLAGS = -module -avoid-version \
	`mysql_config --libs`                     \
	$(NULL)


libdoclet_la_LIBADD =                           \
	../../../libvaladoc/libvaladoc.la           \
	../../htmlhelpers/languages/libapiwriter.la \
	$(GLIB_LIBS)                                \
	$(LIBVALA_LIBS)                             \
	$(NULL)


EXTRA_DIST = $(libdoclet_VALASOURCES)  libdoclet.vala.stamp 
