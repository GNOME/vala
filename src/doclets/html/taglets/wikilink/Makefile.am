# src/Makefile.am



libtagletwikilink_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletwikilink.vala.stamp


libtagletwikilink.vala.stamp: $(libtagletwikilink_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

tagletwikilinkdir = $(libdir)/valadoc/plugins/template/taglets/

tagletwikilink_LTLIBRARIES = libtagletwikilink.la


libtagletwikilink_la_SOURCES =                \
	libtagletwikilink.vala.stamp              \
	$(libtagletwikilink_VALASOURCES:.vala=.c) \
	$(libtagletwikilink_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletwikilink_la_LDFLAGS = -module -avoid-version


libtagletwikilink_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la      \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletwikilink_VALASOURCES)  libtagletwikilink.vala.stamp 
