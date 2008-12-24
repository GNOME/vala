# src/Makefile.am



libtagletnotification_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletnotification.vala.stamp


libtagletnotification.vala.stamp: $(libtagletnotification_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

tagletnotificationdir = $(libdir)/valadoc/plugins/devhelp/taglets/

tagletnotification_LTLIBRARIES = libtagletnotification.la


libtagletnotification_la_SOURCES =                \
	libtagletnotification.vala.stamp              \
	$(libtagletnotification_VALASOURCES:.vala=.c) \
	$(libtagletnotification_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletnotification_la_LDFLAGS = -module -avoid-version


libtagletnotification_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la      \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletnotification_VALASOURCES)  libtagletnotification.vala.stamp 
