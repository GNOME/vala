NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletright.vala.stamp


tagletrightdir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


tagletright_LTLIBRARIES = \
	libtagletright.la     \
	$(NULL)


libtagletright_la_VALASOURCES = \
	taglet.vala                 \
	$(NULL)


libtagletright_la_SOURCES =                \
	libtagletright.vala.stamp              \
	$(libtagletright_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletright.vala.stamp: $(libtagletright_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtagletright_la_LDFLAGS = -module -avoid-version


libtagletright_la_LIBADD =               \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletright_la_VALASOURCES)  libtagletright.vala.stamp 


MAINTAINERCLEANFILES =                        \
	$(libtagletright_la_VALASOURCES:.vala=.c) \
	$(NULL)

