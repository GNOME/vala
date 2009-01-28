# src/Makefile.am



libtagletsee_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletsee.vala.stamp


libtagletsee.vala.stamp: $(libtagletsee_VALASOURCES)
	$(VALAC) -C --vapidir ../../../htmlhelpers --pkg libhtmlhelpers-1.0 --vapidir ../../../../vapi --pkg valadoc-1.0 --basedir . $^
	touch $@


	

tagletseedir = $(libdir)/valadoc/plugins/devhelp/taglets/

tagletsee_LTLIBRARIES = libtagletsee.la


libtagletsee_la_SOURCES =                \
	libtagletsee.vala.stamp              \
	$(libtagletsee_VALASOURCES:.vala=.c) \
	$(libtagletsee_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../                    \
	$(GLIB_CFLAGS)            \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libtagletsee_la_LDFLAGS = -module -avoid-version


libtagletsee_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la \
	../../../htmlhelpers/libhtmlhelpers.la \
	$(GLIB_LIBS)                      \
	$(LIBVALA_LIBS)                   \
	$(NULL)




EXTRA_DIST = $(libtagletsee_VALASOURCES)  libtagletsee.vala.stamp 
