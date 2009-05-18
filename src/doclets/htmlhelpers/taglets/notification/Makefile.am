NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletnotification.vala.stamp


tagletnotificationdir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


tagletnotification_LTLIBRARIES =         \
	libtagletnotification.la \
	$(NULL)


libtagletnotification_la_VALASOURCES = \
	taglet.vala                        \
	$(NULL)


libtagletnotification_la_SOURCES =                \
	libtagletnotification.vala.stamp              \
	$(libtagletnotification_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletnotification.vala.stamp: $(libtagletnotification_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtagletnotification_la_LDFLAGS = -module -avoid-version


libtagletnotification_la_LIBADD =        \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletnotification_la_VALASOURCES)  libtagletnotification.vala.stamp 


MAINTAINERCLEANFILES =                               \
	$(libtagletnotification_la_VALASOURCES:.vala=.c) \
	$(NULL)

