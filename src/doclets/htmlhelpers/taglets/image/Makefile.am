NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(LIBGDKPIXBUF_CFLAGS)       \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletimage.vala.stamp


tagletimagedir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


tagletimage_LTLIBRARIES = \
	libtagletimage.la     \
	$(NULL)


libtagletimage_la_VALASOURCES = \
	taglet.vala                 \
	$(NULL)


libtagletimage_la_SOURCES =                   \
	libtagletimage.vala.stamp                 \
	$(libtagletimage_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletimage.vala.stamp: $(libtagletimage_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --pkg gdk-pixbuf-2.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtagletimage_la_LDFLAGS = -module -avoid-version


libtagletimage_la_LIBADD =               \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGDKPIXBUF_LIBS)                 \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletimage_la_VALASOURCES)  libtagletimage.vala.stamp 


MAINTAINERCLEANFILES =                        \
	$(libtagletimage_la_VALASOURCES:.vala=.c) \
	$(NULL)

