NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletsource.vala.stamp


tagletsourcedir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


tagletsource_LTLIBRARIES = \
	libtagletsource.la     \
	$(NULL)


libtagletsource_la_VALASOURCES = \
	taglet.vala                  \
	$(NULL)


libtagletsource_la_SOURCES =                \
	libtagletsource.vala.stamp              \
	$(libtagletsource_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletsource.vala.stamp: $(libtagletsource_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtagletsource_la_LDFLAGS = -module -avoid-version


libtagletsource_la_LIBADD =              \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletsource_la_VALASOURCES)  libtagletsource.vala.stamp 


MAINTAINERCLEANFILES =                         \
	$(libtagletsource_la_VALASOURCES:.vala=.c) \
	$(NULL)

