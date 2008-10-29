# src/Makefile.am



libtagletXXXX_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletXXXX.vala.stamp


libtagletXXXX.vala.stamp: $(libtagletXXXX_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

tagletXXXXdir = $(libdir)/valadoc/plugins/devhelp/taglets/

tagletXXXX_LTLIBRARIES = libtagletXXXX.la


libtagletXXXX_la_SOURCES =                \
	libtagletXXXX.vala.stamp              \
	$(libtagletXXXX_VALASOURCES:.vala=.c) \
	$(libtagletXXXX_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-I ../../../../libvaladoc/   \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)            \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libtagletXXXX_la_LDFLAGS = -module -avoid-version


libtagletXXXX_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la \
	../../linkhelper/libhtmlhelper.la    \
	$(GLIB_LIBS)                      \
	$(LIBVALA_LIBS)                   \
	$(NULL)




EXTRA_DIST = $(libtagletXXXX_VALASOURCES)  libtagletXXXX.vala.stamp 
