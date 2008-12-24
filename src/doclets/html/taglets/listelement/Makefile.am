# src/Makefile.am



libtagletlistelement_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletlistelement.vala.stamp


libtagletlistelement.vala.stamp: $(libtagletlistelement_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

tagletlistelementdir = $(libdir)/valadoc/plugins/template/taglets/

tagletlistelement_LTLIBRARIES = libtagletlistelement.la


libtagletlistelement_la_SOURCES =                \
	libtagletlistelement.vala.stamp              \
	$(libtagletlistelement_VALASOURCES:.vala=.c) \
	$(libtagletlistelement_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletlistelement_la_LDFLAGS = -module -avoid-version


libtagletlistelement_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la      \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletlistelement_VALASOURCES)  libtagletlistelement.vala.stamp 
