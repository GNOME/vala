# src/Makefile.am



libtagletlist_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletlist.vala.stamp


libtagletlist.vala.stamp: $(libtagletlist_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


	

tagletlistdir = $(libdir)/valadoc/plugins/devhelp/taglets/

tagletlist_LTLIBRARIES = libtagletlist.la


libtagletlist_la_SOURCES =                \
	libtagletlist.vala.stamp              \
	$(libtagletlist_VALASOURCES:.vala=.c) \
	$(libtagletlist_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletlist_la_LDFLAGS = -module -avoid-version


libtagletlist_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletlist_VALASOURCES)  libtagletlist.vala.stamp 
