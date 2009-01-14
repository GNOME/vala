# src/Makefile.am



libtagletsrcsample_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletsrcsample.vala.stamp


libtagletsrcsample.vala.stamp: $(libtagletsrcsample_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --pkg libhtmlhelper-1.0 --basedir . --save-temps $^
	touch $@


	

tagletsrcsampledir = $(libdir)/valadoc/plugins/template/taglets/

tagletsrcsample_LTLIBRARIES = libtagletsrcsample.la


libtagletsrcsample_la_SOURCES =                \
	libtagletsrcsample.vala.stamp              \
	$(libtagletsrcsample_VALASOURCES:.vala=.c) \
	$(libtagletsrcsample_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletsrcsample_la_LDFLAGS = -module -avoid-version


libtagletsrcsample_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la      \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletsrcsample_VALASOURCES)  libtagletsrcsample.vala.stamp 
