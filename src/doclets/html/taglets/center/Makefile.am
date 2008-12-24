# src/Makefile.am



libtagletcenter_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletcenter.vala.stamp


libtagletcenter.vala.stamp: $(libtagletcenter_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

tagletimagedir = $(libdir)/valadoc/plugins/template/taglets/

tagletimage_LTLIBRARIES = libtagletcenter.la


libtagletcenter_la_SOURCES =                \
	libtagletcenter.vala.stamp              \
	$(libtagletcenter_VALASOURCES:.vala=.c) \
	$(libtagletcenter_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletcenter_la_LDFLAGS = -module -avoid-version


libtagletcenter_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la      \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletcenter_VALASOURCES)  libtagletcenter.vala.stamp 
