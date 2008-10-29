# src/Makefile.am



libhtmlhelper_VALASOURCES = \
	helper.vala             \
	$(NULL)


BUILT_SOURCES = libhtmlhelper.vala.stamp


libhtmlhelper.vala.stamp: $(libhtmlhelper_VALASOURCES)
	$(VALAC) -C --library libhtmlhelper-1.0 --basedir . --vapidir ../../../vapi --pkg valadoc-1.0 --disable-non-null $^
	touch $@



htmlhelperdir = $(libdir)/valadoc/plugins/valadoc.org/
htmlhelper_LTLIBRARIES = libhtmlhelper.la


libhtmlhelper_la_SOURCES =                \
	libhtmlhelper.vala.stamp              \
	$(libhtmlhelper_VALASOURCES:.vala=.c) \
	$(libhtmlhelper_VALASOURCES:.vala=.h) \
	$(NULL)


AM_CFLAGS =             \
	-I ../../../libvaladoc/   \
	$(LIBVALA_CFLAGS)   \
	$(GLIB_CFLAGS)      \
	$(NULL)


libhtmlhelper_la_LIBADD = \
	../../../libvaladoc/libvaladoc.la \
	$(LIBVALA_LIBS)                \
	$(GLIB_LIBS)                   \
	$(NULL)


EXTRA_DIST = $(libhtmlhelper_VALASOURCES)  libhtmlhelper.vala.stamp 
