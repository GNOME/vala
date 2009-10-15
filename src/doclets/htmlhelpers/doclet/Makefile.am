NULL =


AM_CFLAGS =                   \
	-I ../../../libvaladoc/   \
	$(LIBGVC_CFLAGS)          \
	$(LIBVALA_CFLAGS)         \
	$(GLIB_CFLAGS)            \
	$(LIBGEE_CFLAGS)          \
	$(NULL)



BUILT_SOURCES = libhtmlhelpers.vala.stamp


htmlhelpersdir = $(libdir)/valadoc/plugins/htmlhelpers/


htmlhelpers_LTLIBRARIES =   \
	libhtmlhelpers.la  \
	$(NULL)


libhtmlhelpers_la_VALASOURCES = \
	globals.vala                \
	langlet.vala                \
	doclet.vala                 \
	htmlrenderer.vala                 \
	$(NULL)


libhtmlhelpers_la_SOURCES =                \
	libhtmlhelpers.vala.stamp              \
	$(libhtmlhelpers_la_VALASOURCES:.vala=.c) \
	$(NULL)


libhtmlhelpersinclude_HEADERS =  \
	libhtmlhelpers-1.0.h         \
	$(NULL)


libhtmlhelpersincludedir = $(includedir)/vala-1.0


libhtmlhelpers.vala.stamp: $(libhtmlhelpers_la_VALASOURCES)
	$(VALAC) -C -H libhtmlhelpers-1.0.h --library libhtmlhelpers-1.0 --basedir . --vapidir ../../../vapi --pkg valadoc-1.0 --pkg gee-1.0 --save-temps $^
	touch $@


libhtmlhelpers_la_LIBADD =              \
	../../../libvaladoc/libvaladoc.la   \
	$(LIBGVC_LIBS)                      \
	$(LIBVALA_LIBS)                     \
	$(GLIB_LIBS)                        \
	$(LIBGEE_LIBS)                      \
	$(NULL)


EXTRA_DIST = $(libhtmlhelpers_la_VALASOURCES)  libhtmlhelpers.vala.stamp 


MAINTAINERCLEANFILES =                        \
	libhtmlhelpers-1.0.vapi                   \
	libhtmlhelpers-1.0.gir                    \
	libhtmlhelpers-1.0.h                      \
	$(libhtmlhelpers_la_VALASOURCES:.vala=.c) \
	$(NULL)

