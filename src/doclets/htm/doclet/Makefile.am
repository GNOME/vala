NULL =


AM_CFLAGS =  -g                                             \
	-DPACKAGE_PLUGINDIR=\"$(libdir)/valadoc/plugins/html/\" \
	-I ../../../libvaladoc/                                 \
	-I ../../htmlhelpers/doclet/                            \
	-I ../                                                  \
	$(GLIB_CFLAGS)                                          \
	$(LIBVALA_CFLAGS)                                       \
	$(NULL)



BUILT_SOURCES = libdoclet.vala.stamp


docletdir = $(libdir)/valadoc/plugins/html/


libdoclet_la_LDFLAGS = -module -avoid-version


doclet_LTLIBRARIES =  \
	libdoclet.la      \
	$(NULL)


libdoclet_la_VALASOURCES = \
	doclet.vala            \
	$(NULL)


libdoclet_la_SOURCES =      \
	libdoclet.vala.stamp                 \
	$(libdoclet_la_VALASOURCES:.vala=.c) \
	$(NULL)


libdoclet.vala.stamp: $(libdoclet_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../htmlhelpers/doclet --pkg libhtmlhelpers-1.0 --vapidir ../../../vapi --pkg valadoc-1.0 --vapidir . --pkg docletconfig --basedir . $^
	touch $@


libdoclet_la_LIBADD =                          \
	../../../libvaladoc/libvaladoc.la          \
	../../htmlhelpers/doclet/libhtmlhelpers.la \
	$(GLIB_LIBS)                               \
	$(LIBVALA_LIBS)                            \
	$(NULL)


EXTRA_DIST = $(libdoclet_la_VALASOURCES)  libdoclet.vala.stamp 


MAINTAINERCLEANFILES =                   \
	$(libdoclet_la_VALASOURCES:.vala=.c) \
	$(NULL)


install-data-hook:
	cd $(libdir)/valadoc/plugins/html/ && if test -d deps; then unlink deps; fi && ln -s ../htmlhelpers/deps 

