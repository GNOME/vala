NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletlist.vala.stamp


tagletlistdir = $(libdir)/valadoc/plugins/valadoc.org/taglets/


tagletlist_LTLIBRARIES =  \
	libtagletlist.la  \
	$(NULL)


libtagletlist_la_VALASOURCES = \
	taglet.vala                \
	$(NULL)


libtagletlist_la_SOURCES =                \
	libtagletlist.vala.stamp              \
	$(libtagletlist_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletlist.vala.stamp: $(libtagletlist_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --basedir . $^
	touch $@


libtagletlist_la_LDFLAGS = -module -avoid-version


libtagletlist_la_LIBADD =                \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletlist_la_VALASOURCES)  libtagletlist.vala.stamp 


MAINTAINERCLEANFILES =                        \
	$(libtagletlist_la_VALASOURCES:.vala=.c)  \
	$(NULL)

