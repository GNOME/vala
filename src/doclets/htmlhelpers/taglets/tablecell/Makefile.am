NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtaglettablecell.vala.stamp


taglettablecelldir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


taglettablecell_LTLIBRARIES = \
	libtaglettablecell.la     \
	$(NULL)


libtaglettablecell_la_VALASOURCES = \
	taglet.vala                     \
	$(NULL)


libtaglettablecell_la_SOURCES =                \
	libtaglettablecell.vala.stamp              \
	$(libtaglettablecell_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtaglettablecell.vala.stamp: $(libtaglettablecell_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtaglettablecell_la_LDFLAGS = -module -avoid-version


libtaglettablecell_la_LIBADD =           \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtaglettablecell_la_VALASOURCES)  libtaglettablecell.vala.stamp 


MAINTAINERCLEANFILES =                            \
	$(libtaglettablecell_la_VALASOURCES:.vala=.c) \
	$(NULL)

