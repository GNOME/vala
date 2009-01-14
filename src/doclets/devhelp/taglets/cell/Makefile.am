# src/Makefile.am



libtaglettablecell_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtaglettablecell.vala.stamp


libtaglettablecell.vala.stamp: $(libtaglettablecell_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --pkg libhtmlhelper-1.0 --basedir . --save-temps $^
	touch $@


	

taglettablecelldir = $(libdir)/valadoc/plugins/devhelp/taglets/

taglettablecell_LTLIBRARIES = libtaglettablecell.la


libtaglettablecell_la_SOURCES =                \
	libtaglettablecell.vala.stamp              \
	$(libtaglettablecell_VALASOURCES:.vala=.c) \
	$(libtaglettablecell_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtaglettablecell_la_LDFLAGS = -module -avoid-version


libtaglettablecell_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la      \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtaglettablecell_VALASOURCES)  libtaglettablecell.vala.stamp 
