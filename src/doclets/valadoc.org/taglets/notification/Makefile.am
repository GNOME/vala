NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletnotification.vala.stamp


tagletnotificationdir = $(libdir)/valadoc/plugins/valadoc.org/taglets/


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
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --basedir . $^
	touch $@


libtagletnotification_la_LDFLAGS = -module -avoid-version


libtagletnotification_la_LIBADD =        \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletnotification_la_VALASOURCES)  libtagletnotification.vala.stamp 


MAINTAINERCLEANFILES =                               \
	$(libtagletnotification_la_VALASOURCES:.vala=.c) \
	$(NULL)

