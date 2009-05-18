NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletthrows.vala.stamp


tagletthrowsdir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


tagletthrows_LTLIBRARIES = \
	libtagletthrows.la     \
	$(NULL)


libtagletthrows_la_VALASOURCES = \
	taglet.vala                  \
	$(NULL)


libtagletthrows_la_SOURCES =                \
	libtagletthrows.vala.stamp              \
	$(libtagletthrows_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletthrows.vala.stamp: $(libtagletthrows_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtagletthrows_la_LDFLAGS = -module -avoid-version


libtagletthrows_la_LIBADD =              \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletthrows_la_VALASOURCES)  libtagletthrows.vala.stamp 


MAINTAINERCLEANFILES =                         \
	$(libtagletthrows_la_VALASOURCES:.vala=.c) \
	$(NULL)

