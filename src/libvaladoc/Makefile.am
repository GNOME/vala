# src/Makefile.am



libvaladoc_VALASOURCES = \
	drawer.vala          \
	settings.vala        \
	doclet.vala          \
	errorreporter.vala   \
	parser.vala          \
	doctree.vala         \
	langlet.vala         \
	$(NULL)


BUILT_SOURCES = libvaladoc.vala.stamp


libvaladoc.vala.stamp: $(libvaladoc_VALASOURCES)
	$(VALAC) -C --pkg vala-1.0 --pkg gmodule-2.0 --vapidir ../vapi --pkg libxml-2.0 --pkg libgvc --library valadoc-1.0 --basedir $(top_srcdir)/src/libvaladoc/ --save-temps $^
	touch $@


vapis:
	
valadocdir = $(libdir)/valadoc/
valadoc_LTLIBRARIES = libvaladoc.la


libvaladoc_la_SOURCES =                \
	libvaladoc.vala.stamp              \
	$(libvaladoc_VALASOURCES:.vala=.c) \
	$(libvaladoc_VALASOURCES:.vala=.h) \
	$(NULL)


ccodeincludedir = $(includedir)/valadoc-1.0

ccodeinclude_HEADERS =                 \
	$(libvaladoc_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =             \
	$(LIBXML2_CFLAGS)   \
	$(GLIB_CFLAGS)      \
	$(LIBVALA_CFLAGS)   \
	$(GMODULE_CFLAGS)   \
	$(LIBGVC_CFLAGS)    \
	$(NULL)


libvaladoc_la_LIBADD = \
	$(LIBXML2_LIBS)    \
	$(GLIB_LIBS)       \
	$(LIBVALA_LIBS)    \
	$(GMODULE_LIBS)    \
	$(LIBGVC_LIBS)     \
	$(NULL)


pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = valadoc-1.0.pc



EXTRA_DIST = $(libvaladoc_VALASOURCES)  libvaladoc.vala.stamp 
