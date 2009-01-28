# src/Makefile.am



libtagletcenter_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletcenter.vala.stamp


libtagletcenter.vala.stamp: $(libtagletcenter_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


	

tagletcenterdir = $(libdir)/valadoc/plugins/devhelp/taglets/

tagletcenter_LTLIBRARIES = libtagletcenter.la


libtagletcenter_la_SOURCES =                \
	libtagletcenter.vala.stamp              \
	$(libtagletcenter_VALASOURCES:.vala=.c) \
	$(libtagletcenter_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletcenter_la_LDFLAGS = -module -avoid-version


libtagletcenter_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletcenter_VALASOURCES)  libtagletcenter.vala.stamp 
