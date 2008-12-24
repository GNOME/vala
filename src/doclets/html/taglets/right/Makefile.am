# src/Makefile.am



libtagletright_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletright.vala.stamp


libtagletright.vala.stamp: $(libtagletright_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

tagletrightdir = $(libdir)/valadoc/plugins/template/taglets/

tagletright_LTLIBRARIES = libtagletright.la


libtagletright_la_SOURCES =                \
	libtagletright.vala.stamp              \
	$(libtagletright_VALASOURCES:.vala=.c) \
	$(libtagletright_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtagletright_la_LDFLAGS = -module -avoid-version


libtagletright_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la      \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtagletright_VALASOURCES)  libtagletright.vala.stamp 
