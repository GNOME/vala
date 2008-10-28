# src/Makefile.am



libtagletstring_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletstring.vala.stamp


libtagletstring.vala.stamp: $(libtagletstring_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

tagletstringdir = $(libdir)/valadoc/plugins/template/taglets/

tagletstring_LTLIBRARIES = libtagletstring.la


libtagletstring_la_SOURCES =                \
	libtagletstring.vala.stamp              \
	$(libtagletstring_VALASOURCES:.vala=.c) \
	$(libtagletstring_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-I ../../../../libvaladoc/   \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)            \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libtagletstring_la_LDFLAGS = -module -avoid-version


libtagletstring_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la \
	../../linkhelper/libhtmlhelper.la    \
	$(GLIB_LIBS)                      \
	$(LIBVALA_LIBS)                   \
	$(NULL)




EXTRA_DIST = $(libtagletstring_VALASOURCES)  libtagletstring.vala.stamp 
