NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletunderline.vala.stamp


tagletunderlinedir = $(libdir)/valadoc/plugins/valadoc.org/taglets/


tagletunderline_LTLIBRARIES = \
	libtagletunderline.la     \
	$(NULL)


libtagletunderline_la_VALASOURCES = \
	taglet.vala                     \
	$(NULL)


libtagletunderline_la_SOURCES =                \
	libtagletunderline.vala.stamp              \
	$(libtagletunderline_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletunderline.vala.stamp: $(libtagletunderline_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --basedir . $^
	touch $@


libtagletunderline_la_LDFLAGS = -module -avoid-version


libtagletunderline_la_LIBADD =           \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletunderline_la_VALASOURCES)  libtagletunderline.vala.stamp 


MAINTAINERCLEANFILES =                            \
	$(libtagletunderline_la_VALASOURCES:.vala=.c) \
	$(NULL)

