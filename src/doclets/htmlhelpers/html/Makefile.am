NULL =


AM_CFLAGS =  -g                  \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libhtmlwriter.vala.stamp


htmlwriterdir = $(libdir)/valadoc/plugins/htmlhelpers/


htmlwriter_LTLIBRARIES = \
	libhtmlwriter.la     \
	$(NULL)


libhtmlwriter_la_VALASOURCES = \
	htmlwriter.vala \
	attribute.vala  \
	block.vala      \
	inline.vala     \
	$(NULL)


libhtmlwriter_la_SOURCES =                   \
	libhtmlwriter.vala.stamp                 \
	$(libhtmlwriter_la_VALASOURCES:.vala=.c) \
	$(NULL)


libhtmlwriter.vala.stamp: $(libhtmlwriter_la_VALASOURCES)
	$(VALAC) -C --pkg vala-1.0 --basedir . --save-temps --library htmlwriter-1.0 -H htmlwriter-1.0.h $^
	touch $@


libhtmlwriter_la_LDFLAGS = $(NULL)


libhtmlwriter_la_LIBADD =            \
	$(GLIB_LIBS)                     \
	$(LIBVALA_LIBS)                  \
	$(NULL)


EXTRA_DIST = $(libhtmlwriter_la_VALASOURCES)  libhtmlwriter.vala.stamp 


MAINTAINERCLEANFILES =                           \
	$(libhtmlwriter_la_VALASOURCES:.vala=.c) \
	$(NULL)

