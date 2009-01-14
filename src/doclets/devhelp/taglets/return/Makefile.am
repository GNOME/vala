# src/Makefile.am



libtagletXXXX_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletXXXX.vala.stamp


libtagletXXXX.vala.stamp: $(libtagletXXXX_VALASOURCES)
	$(VALAC) -C --vapidir ../../../htmlhelpers --pkg libhtmlhelpers-1.0 --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --pkg libhtmlhelper-1.0 --basedir . --save-temps $^
	touch $@


	

tagletXXXXdir = $(libdir)/valadoc/plugins/devhelp/taglets/

tagletXXXX_LTLIBRARIES = libtagletXXXX.la


libtagletXXXX_la_SOURCES =                \
	libtagletXXXX.vala.stamp              \
	$(libtagletXXXX_VALASOURCES:.vala=.c) \
	$(libtagletXXXX_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)            \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libtagletXXXX_la_LDFLAGS = -module -avoid-version


libtagletXXXX_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la    \
	$(GLIB_LIBS)                      \
	$(LIBVALA_LIBS)                   \
	$(NULL)




EXTRA_DIST = $(libtagletXXXX_VALASOURCES)  libtagletXXXX.vala.stamp 
