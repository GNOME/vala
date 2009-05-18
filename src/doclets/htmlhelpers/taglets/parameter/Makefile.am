NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletparameter.vala.stamp


tagletparameterdir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


tagletparameter_LTLIBRARIES =         \
	libtagletparameter.la \
	$(NULL)


libtagletparameter_la_VALASOURCES = \
	taglet.vala                     \
	$(NULL)


libtagletparameter_la_SOURCES =                \
	libtagletparameter.vala.stamp              \
	$(libtagletparameter_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletparameter.vala.stamp: $(libtagletparameter_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtagletparameter_la_LDFLAGS = -module -avoid-version


libtagletparameter_la_LIBADD =           \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletparameter_la_VALASOURCES)  libtagletparameter.vala.stamp 


MAINTAINERCLEANFILES =                            \
	$(libtagletparameter_la_VALASOURCES:.vala=.c) \
	$(NULL)

