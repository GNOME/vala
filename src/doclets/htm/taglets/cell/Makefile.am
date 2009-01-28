# src/Makefile.am



libtaglettablecell_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtaglettablecell.vala.stamp


libtaglettablecell.vala.stamp: $(libtaglettablecell_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../../htmlhelpers/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


	

taglettablecelldir = $(libdir)/valadoc/plugins/html/taglets/

taglettablecell_LTLIBRARIES = libtaglettablecell.la


libtaglettablecell_la_SOURCES =                \
	libtaglettablecell.vala.stamp              \
	$(libtaglettablecell_VALASOURCES:.vala=.c) \
	$(libtaglettablecell_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../                    \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


libtaglettablecell_la_LDFLAGS = -module -avoid-version


libtaglettablecell_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la   \
	../../../htmlhelpers/libhtmlhelpers.la \
	$(GLIB_LIBS)                           \
	$(LIBVALA_LIBS)                        \
	$(NULL)




EXTRA_DIST = $(libtaglettablecell_VALASOURCES)  libtaglettablecell.vala.stamp 
