NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletcenter.vala.stamp


tagletcenterdir = $(libdir)/valadoc/plugins/valadoc.org/taglets/


tagletcenter_LTLIBRARIES = \
	libtagletcenter.la     \
	$(NULL)


libtagletcenter_la_VALASOURCES = \
	taglet.vala                  \
	$(NULL)


libtagletcenter_la_SOURCES =                   \
	libtagletcenter.vala.stamp                 \
	$(libtagletcenter_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletcenter.vala.stamp: $(libtagletcenter_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --basedir . $^
	touch $@


libtagletcenter_la_LDFLAGS = -module -avoid-version


libtagletcenter_la_LIBADD =              \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletcenter_la_VALASOURCES)  libtagletcenter.vala.stamp 


MAINTAINERCLEANFILES =                         \
	$(libtagletcenter_la_VALASOURCES:.vala=.c) \
	$(NULL)

