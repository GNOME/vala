NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletsince.vala.stamp


tagletsincedir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


tagletsince_LTLIBRARIES = \
	libtagletsince.la     \
	$(NULL)


libtagletsince_la_VALASOURCES = \
	taglet.vala                 \
	$(NULL)


libtagletsince_la_SOURCES =                \
	libtagletsince.vala.stamp              \
	$(libtagletsince_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletsince.vala.stamp: $(libtagletsince_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtagletsince_la_LDFLAGS = -module -avoid-version


libtagletsince_la_LIBADD =               \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletsince_la_VALASOURCES)  libtagletsince.vala.stamp 


MAINTAINERCLEANFILES =                        \
	$(libtagletsince_la_VALASOURCES:.vala=.c) \
	$(NULL)

