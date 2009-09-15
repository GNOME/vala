NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletcodeconstant.vala.stamp


tagletcodeconstantdir = $(libdir)/valadoc/plugins/valadoc.org/taglets/


tagletcodeconstant_LTLIBRARIES = \
	libtagletcodeconstant.la     \
	$(NULL)


libtagletcodeconstant_la_VALASOURCES = \
	taglet.vala                    \
	$(NULL)


libtagletcodeconstant_la_SOURCES =                   \
	libtagletcodeconstant.vala.stamp                 \
	$(libtagletcodeconstant_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletcodeconstant.vala.stamp: $(libtagletcodeconstant_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --basedir . $^
	touch $@


libtagletcodeconstant_la_LDFLAGS = -module -avoid-version


libtagletcodeconstant_la_LIBADD =            \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletcodeconstant_la_VALASOURCES)  libtagletcodeconstant.vala.stamp 


MAINTAINERCLEANFILES =                           \
	$(libtagletcodeconstant_la_VALASOURCES:.vala=.c) \
	$(NULL)

