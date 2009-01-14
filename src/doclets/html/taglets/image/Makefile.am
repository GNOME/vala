# src/Makefile.am



libtagletimage_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletimage.vala.stamp


libtagletimage.vala.stamp: $(libtagletimage_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --pkg libhtmlhelper-1.0 --basedir . --save-temps $^
	touch $@


	

tagletimagedir = $(libdir)/valadoc/plugins/template/taglets/

tagletimage_LTLIBRARIES = libtagletimage.la


libtagletimage_la_SOURCES =                \
	libtagletimage.vala.stamp              \
	$(libtagletimage_VALASOURCES:.vala=.c) \
	$(libtagletimage_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletimage_la_LDFLAGS = -module -avoid-version


libtagletimage_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la      \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletimage_VALASOURCES)  libtagletimage.vala.stamp 
