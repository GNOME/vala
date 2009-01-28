# src/Makefile.am



libhtmlhelpers_VALASOURCES = \
	htmlhelpers.vala        \
	$(NULL)


BUILT_SOURCES = libhtmlhelpers.vala.stamp


libhtmlhelpers.vala.stamp: $(libhtmlhelpers_VALASOURCES)
	$(VALAC) -C --library libhtmlhelpers-1.0 --basedir . --vapidir ../../vapi --pkg valadoc-1.0 --save-temps $^
	touch $@



htmlhelpersdir = $(libdir)/valadoc/plugins/
htmlhelpers_LTLIBRARIES = libhtmlhelpers.la


libhtmlhelpers_la_SOURCES =                \
	libhtmlhelpers.vala.stamp              \
	$(libhtmlhelpers_VALASOURCES:.vala=.c) \
	$(libhtmlhelpers_VALASOURCES:.vala=.h) \
	$(NULL)


AM_CFLAGS =             \
	-I ../../libvaladoc/   \
	$(LIBGVC_CFLAGS)    \
	$(LIBVALA_CFLAGS)   \
	$(GLIB_CFLAGS)      \
	$(NULL)


libhtmlhelper_la_LIBADD = \
	../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)     \
	$(LIBVALA_LIBS)                \
	$(GLIB_LIBS)                   \
	$(NULL)


EXTRA_DIST = $(libhtmlhelpers_VALASOURCES)  libhtmlhelpers.vala.stamp 
