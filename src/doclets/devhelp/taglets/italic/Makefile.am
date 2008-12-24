# src/Makefile.am



libtagletitalic_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletitalic.vala.stamp


libtagletitalic.vala.stamp: $(libtagletitalic_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

tagletitalicdir = $(libdir)/valadoc/plugins/devhelp/taglets/

tagletitalic_LTLIBRARIES = libtagletitalic.la


libtagletitalic_la_SOURCES =                \
	libtagletitalic.vala.stamp              \
	$(libtagletitalic_VALASOURCES:.vala=.c) \
	$(libtagletitalic_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletitalic_la_LDFLAGS = -module -avoid-version


libtagletitalic_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la      \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletitalic_VALASOURCES)  libtagletitalic.vala.stamp 
