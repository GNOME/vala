NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletparagraph.vala.stamp


tagletparagraphdir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


tagletparagraph_LTLIBRARIES =    \
	libtagletparagraph.la  \
	$(NULL)


libtagletparagraph_la_VALASOURCES = \
	taglet.vala                  \
	$(NULL)


libtagletparagraph_la_SOURCES =                \
	libtagletparagraph.vala.stamp              \
	$(libtagletparagraph_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletparagraph.vala.stamp: $(libtagletparagraph_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtagletparagraph_la_LDFLAGS = -module -avoid-version


libtagletparagraph_la_LIBADD =              \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletparagraph_la_VALASOURCES)  libtagletparagraph.vala.stamp 


MAINTAINERCLEANFILES =                         \
	$(libtagletparagraph_la_VALASOURCES:.vala=.c) \
	$(NULL)

