NULL =


AM_CFLAGS =  -g                  \
	-I ../../../libvaladoc/      \
	-I ../html/                  \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libapiwriter.vala.stamp


apiwriterdir = $(libdir)/valadoc/plugins/htmlhelpers/


apiwriter_LTLIBRARIES =  \
	libapiwriter.la      \
	$(NULL)


libapiwriter_la_VALASOURCES = \
	vala.vala                 \
	$(NULL)


libapiwriter_la_SOURCES =                   \
	libapiwriter.vala.stamp                 \
	$(libapiwriter_la_VALASOURCES:.vala=.c) \
	$(NULL)


libapiwriter.vala.stamp: $(libapiwriter_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../vapi --pkg valadoc-1.0 --vapidir ../html/ --pkg htmlwriter-1.0 --basedir . --save-temps -H apiwriter-1.0.h --library apiwriter-1.0 $^
	touch $@


libapiwriter_la_LDFLAGS = -module -avoid-version


libapiwriter_la_LIBADD =                 \
	../../../libvaladoc/libvaladoc.la \
	../html/libhtmlwriter.la                \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libapiwriter_la_VALASOURCES)  libapiwriter.vala.stamp 


MAINTAINERCLEANFILES =                        \
	$(libapiwriter_la_VALASOURCES:.vala=.c)  \
	$(NULL)

