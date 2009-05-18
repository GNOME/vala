NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtaglettypelink.vala.stamp


taglettypelinkdir = $(libdir)/valadoc/plugins/htmlhelpers/taglets


taglettypelink_LTLIBRARIES = \
	libtaglettypelink.la     \
	$(NULL)


libtaglettypelink_la_VALASOURCES = \
	taglet.vala                    \
	$(NULL)


libtaglettypelink_la_SOURCES =                \
	libtaglettypelink.vala.stamp              \
	$(libtaglettypelink_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtaglettypelink.vala.stamp: $(libtaglettypelink_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtaglettypelink_la_LDFLAGS = -module -avoid-version


libtaglettypelink_la_LIBADD =            \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtaglettypelink_la_VALASOURCES)  libtaglettypelink.vala.stamp 


MAINTAINERCLEANFILES =                           \
	$(libtaglettypelink_la_VALASOURCES:.vala=.c) \
	$(NULL)

