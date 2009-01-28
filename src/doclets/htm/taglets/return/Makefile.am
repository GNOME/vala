# src/Makefile.am



libtagletreturn_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletreturn.vala.stamp


libtagletreturn.vala.stamp: $(libtagletreturn_VALASOURCES)
	$(VALAC) -C --vapidir ../../../htmlhelpers --pkg libhtmlhelpers-1.0 --vapidir ../../../../vapi --pkg valadoc-1.0 --basedir . $^
	touch $@


	

tagletXXXXdir = $(libdir)/valadoc/plugins/html/taglets/

tagletXXXX_LTLIBRARIES = libtagletreturn.la


libtagletreturn_la_SOURCES =                \
	libtagletreturn.vala.stamp              \
	$(libtagletreturn_VALASOURCES:.vala=.c) \
	$(libtagletreturn_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../                    \
	$(GLIB_CFLAGS)            \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libtagletreturn_la_LDFLAGS = -module -avoid-version


libtagletreturn_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la \
	../../../htmlhelpers/libhtmlhelpers.la \
	$(GLIB_LIBS)                      \
	$(LIBVALA_LIBS)                   \
	$(NULL)




EXTRA_DIST = $(libtagletreturn_VALASOURCES)  libtagletreturn.vala.stamp 
