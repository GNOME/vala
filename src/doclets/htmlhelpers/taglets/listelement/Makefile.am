NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletlistelement.vala.stamp


tagletlistelementdir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


tagletlistelement_LTLIBRARIES =         \
	libtagletlistelement.la  \
	$(NULL)


libtagletlistelement_la_VALASOURCES = \
	taglet.vala                       \
	$(NULL)


libtagletlistelement_la_SOURCES =                \
	libtagletlistelement.vala.stamp              \
	$(libtagletlistelement_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletlistelement.vala.stamp: $(libtagletlistelement_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtagletlistelement_la_LDFLAGS = -module -avoid-version


libtagletlistelement_la_LIBADD =         \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletlistelement_la_VALASOURCES)  libtagletlistelement.vala.stamp 


MAINTAINERCLEANFILES =                              \
	$(libtagletlistelement_la_VALASOURCES:.vala=.c) \
	$(NULL)

