# src/Makefile.am



libtagletunderline_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletunderline.vala.stamp


libtagletunderline.vala.stamp: $(libtagletunderline_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0  --basedir . $^
	touch $@


	
tagletunderlinedir = $(libdir)/valadoc/plugins/devhelp/taglets/

tagletunderline_LTLIBRARIES = libtagletunderline.la


libtagletunderline_la_SOURCES =                \
	libtagletunderline.vala.stamp              \
	$(libtagletunderline_VALASOURCES:.vala=.c) \
	$(libtagletunderline_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletunderline_la_LDFLAGS = -module -avoid-version


libtagletunderline_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletunderline_VALASOURCES)  libtagletunderline.vala.stamp 
