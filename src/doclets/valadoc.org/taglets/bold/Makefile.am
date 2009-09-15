NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletbold.vala.stamp


tagletbolddir = $(libdir)/valadoc/plugins/valadoc.org/taglets/


tagletbold_LTLIBRARIES =  \
	libtagletbold.la  \
	$(NULL)


libtagletbold_la_VALASOURCES = \
	taglet.vala                \
	$(NULL)


libtagletbold_la_SOURCES =                   \
	libtagletbold.vala.stamp                 \
	$(libtagletbold_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletbold.vala.stamp: $(libtagletbold_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --basedir . $^
	touch $@


libtagletbold_la_LDFLAGS = -module -avoid-version


libtagletbold_la_LIBADD =                \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletbold_la_VALASOURCES)  libtagletbold.vala.stamp 


MAINTAINERCLEANFILES =                        \
	$(libtagletbold_la_VALASOURCES:.vala=.c)  \
	$(NULL)

