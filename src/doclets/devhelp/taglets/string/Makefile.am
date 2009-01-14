# src/Makefile.am



libtagletstring_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletstring.vala.stamp


libtagletstring.vala.stamp: $(libtagletstring_VALASOURCES)
	$(VALAC) -C --vapidir ../../../htmlhelpers --pkg libhtmlhelpers-1.0 --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --pkg libhtmlhelper-1.0 --basedir . --save-temps $^
	touch $@


	

tagletstringdir = $(libdir)/valadoc/plugins/devhelp/taglets/

tagletstring_LTLIBRARIES = libtagletstring.la


libtagletstring_la_SOURCES =                \
	libtagletstring.vala.stamp              \
	$(libtagletstring_VALASOURCES:.vala=.c) \
	$(libtagletstring_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)            \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libtagletstring_la_LDFLAGS = -module -avoid-version


libtagletstring_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la    \
	$(GLIB_LIBS)                      \
	$(LIBVALA_LIBS)                   \
	$(NULL)




EXTRA_DIST = $(libtagletstring_VALASOURCES)  libtagletstring.vala.stamp 
