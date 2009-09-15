NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletsource.vala.stamp


tagletsourcedir = $(libdir)/valadoc/plugins/valadoc.org/taglets/


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
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --basedir . $^
	touch $@


libtagletsource_la_LDFLAGS = -module -avoid-version


libtagletsource_la_LIBADD =              \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletsource_la_VALASOURCES)  libtagletsource.vala.stamp 


MAINTAINERCLEANFILES =                         \
	$(libtagletsource_la_VALASOURCES:.vala=.c) \
	$(NULL)

