NULL =


AM_CFLAGS =  -g \
	-DPACKAGE_ICONDIR=\"$(datadir)/valadoc/icons/\" \
	-I $(top_builddir)/src/libvaladoc/ \
	$(LIBGVC_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(LIBGEE_CFLAGS) \
	$(NULL)



BUILT_SOURCES = libdoclet.vala.stamp


docletdir = $(libdir)/valadoc/doclets/devhelp


libdoclet_la_LDFLAGS = -module -avoid-version -no-undefined


doclet_LTLIBRARIES =  \
	libdoclet.la \
	$(NULL)


libdoclet_la_VALASOURCES = \
	doclet.vala \
	$(NULL)


libdoclet_la_SOURCES =      \
	libdoclet.vala.stamp                 \
	$(libdoclet_la_VALASOURCES:.vala=.c) \
	$(NULL)


libdoclet.vala.stamp: $(libdoclet_la_VALASOURCES)
	$(VALAC) -C --vapidir $(top_srcdir)/src/vapi --vapidir $(top_srcdir)/src/libvaladoc --pkg gee-0.8 --pkg valadoc-1.0 --basedir . $^
	touch $@


libdoclet_la_LIBADD = \
	$(top_builddir)/src/libvaladoc/libvaladoc.la \
	$(GLIB_LIBS) \
	$(LIBGEE_LIBS) \
	$(NULL)


EXTRA_DIST = $(libdoclet_la_VALASOURCES)  libdoclet.vala.stamp 


MAINTAINERCLEANFILES = \
	$(libdoclet_la_VALASOURCES:.vala=.c) \
	$(NULL)


