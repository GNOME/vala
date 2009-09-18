NULL =


AM_CFLAGS =  -g \
	-I ../../../libvaladoc/ \
	-I ../doclet/ \
	$(GLIB_CFLAGS) \
	$(LIBVALA_CFLAGS) \
	$(LIBGDKPIXBUF_CFLAGS) \
	$(NULL)


BUILT_SOURCES = libbasictaglets.vala.stamp


basictagletsdir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


basictaglets_LTLIBRARIES = \
	libbasictaglets.la \
	$(NULL)


libbasictaglets_la_VALASOURCES = \
	bold.vala \
	center.vala \
	constant.vala \
	headline.vala \
	image.vala \
	italic.vala \
	link.vala \
	list.vala \
	listelement.vala \
	notification.vala \
	paragraph.vala \
	parameter.vala \
	return.vala \
	right.vala \
	see.vala \
	since.vala \
	source.vala \
	string.vala \
	table.vala \
	tablecell.vala \
	throws.vala \
	typelink.vala \
	underline.vala \
	registerfunction.vala \
	$(NULL)


libbasictaglets_la_SOURCES =                \
	libbasictaglets.vala.stamp              \
	$(libbasictaglets_la_VALASOURCES:.vala=.c) \
	$(NULL)


libbasictaglets.vala.stamp: $(libbasictaglets_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../vapi --pkg valadoc-1.0 --vapidir ../doclet/ --pkg libhtmlhelpers-1.0 --basedir . --pkg gdk-pixbuf-2.0 $^
	touch $@


libbasictaglets_la_LDFLAGS = -module -avoid-version


libbasictaglets_la_LIBADD =           \
	../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                    \
	$(LIBVALA_LIBS)                   \
	$(GLIB_LIBS)                      \
	$(LIBGDKPIXBUFLIBS_) \
	$(NULL)


EXTRA_DIST = $(libbasictaglets_la_VALASOURCES)  libbasictaglets.vala.stamp 


MAINTAINERCLEANFILES =                            \
	$(libbasictaglets_la_VALASOURCES:.vala=.c) \
	$(NULL)

