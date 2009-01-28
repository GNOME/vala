# src/Makefile.am



libtagletbold_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletbold.vala.stamp


libtagletbold.vala.stamp: $(libtagletbold_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


	

tagletbolddir = $(libdir)/valadoc/plugins/html/taglets/

tagletbold_LTLIBRARIES = libtagletbold.la


libtagletbold_la_SOURCES =                \
	libtagletbold.vala.stamp              \
	$(libtagletbold_VALASOURCES:.vala=.c) \
	$(libtagletbold_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletbold_la_LDFLAGS = -module -avoid-version


libtagletbold_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletbold_VALASOURCES)  libtagletbold.vala.stamp 
