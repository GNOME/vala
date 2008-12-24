# src/Makefile.am



libtaglettable_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtaglettable.vala.stamp


libtaglettable.vala.stamp: $(libtaglettable_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

taglettabledir = $(libdir)/valadoc/plugins/template/taglets/

taglettable_LTLIBRARIES = libtaglettable.la


libtaglettable_la_SOURCES =                \
	libtaglettable.vala.stamp              \
	$(libtaglettable_VALASOURCES:.vala=.c) \
	$(libtaglettable_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtaglettable_la_LDFLAGS = -module -avoid-version


libtaglettable_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la      \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtaglettable_VALASOURCES)  libtaglettable.vala.stamp 
