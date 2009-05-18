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
	filehelper.vala      \
	drawer.vala          \
	settings.vala        \
	doclet.vala          \
	errorreporter.vala   \
	doctree.vala         \
	moduleloader.vala    \
	parser.vala          \
	apitree.vala         \
	langlet.vala         \
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

