# src/Makefile.am



libtagletlink_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletlink.vala.stamp


libtagletlink.vala.stamp: $(libtagletlink_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

tagletlinkdir = $(libdir)/valadoc/plugins/template/taglets/

tagletlink_LTLIBRARIES = libtagletlink.la


libtagletlink_la_SOURCES =                \
	libtagletlink.vala.stamp              \
	$(libtagletlink_VALASOURCES:.vala=.c) \
	$(libtagletlink_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-I ../../../../libvaladoc/   \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)            \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libtagletlink_la_LDFLAGS = -module -avoid-version


libtagletlink_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la \
	../../linkhelper/libhtmlhelper.la    \
	$(GLIB_LIBS)                      \
	$(LIBVALA_LIBS)                   \
	$(NULL)




EXTRA_DIST = $(libtagletlink_VALASOURCES)  libtagletlink.vala.stamp 
