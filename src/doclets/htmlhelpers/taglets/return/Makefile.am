NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletreturn.vala.stamp


tagletreturndir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


tagletreturn_LTLIBRARIES =    \
	libtagletreturn.la  \
	$(NULL)


libtagletreturn_la_VALASOURCES = \
	taglet.vala                  \
	$(NULL)


libtagletreturn_la_SOURCES =                \
	libtagletreturn.vala.stamp              \
	$(libtagletreturn_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletreturn.vala.stamp: $(libtagletreturn_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtagletreturn_la_LDFLAGS = -module -avoid-version


libtagletreturn_la_LIBADD =              \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletreturn_la_VALASOURCES)  libtagletreturn.vala.stamp 


MAINTAINERCLEANFILES =                         \
	$(libtagletreturn_la_VALASOURCES:.vala=.c) \
	$(NULL)

