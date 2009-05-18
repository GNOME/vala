NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtaglettable.vala.stamp


taglettabledir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


taglettable_LTLIBRARIES = \
	libtaglettable.la     \
	$(NULL)


libtaglettable_la_VALASOURCES = \
	taglet.vala                 \
	$(NULL)


libtaglettable_la_SOURCES =                \
	libtaglettable.vala.stamp              \
	$(libtaglettable_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtaglettable.vala.stamp: $(libtaglettable_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtaglettable_la_LDFLAGS = -module -avoid-version


libtaglettable_la_LIBADD =               \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtaglettable_la_VALASOURCES)  libtaglettable.vala.stamp 


MAINTAINERCLEANFILES =                        \
	$(libtaglettable_la_VALASOURCES:.vala=.c) \
	$(NULL)

