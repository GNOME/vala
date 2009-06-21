NULL =


AM_CFLAGS =  -g                  \
	-I ../../../../libvaladoc/   \
	-I ../../doclet/             \
	$(GLIB_CFLAGS)               \
	$(LIBVALA_CFLAGS)            \
	$(NULL)


BUILT_SOURCES = libtagletheadline.vala.stamp


tagletheadlinedir = $(libdir)/valadoc/plugins/htmlhelpers/taglets/


tagletheadline_LTLIBRARIES = \
	libtagletheadline.la     \
	$(NULL)


libtagletheadline_la_VALASOURCES = \
	taglet.vala                    \
	$(NULL)


libtagletheadline_la_SOURCES =                   \
	libtagletheadline.vala.stamp                 \
	$(libtagletheadline_la_VALASOURCES:.vala=.c) \
	$(NULL)


libtagletheadline.vala.stamp: $(libtagletheadline_la_VALASOURCES)
	$(VALAC) -C --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../doclet/ --pkg libhtmlhelpers-1.0 --basedir . $^
	touch $@


libtagletheadline_la_LDFLAGS = -module -avoid-version


libtagletheadline_la_LIBADD =            \
	../../../../libvaladoc/libvaladoc.la \
	$(LIBGVC_LIBS)                       \
	$(LIBVALA_LIBS)                      \
	$(GLIB_LIBS)                         \
	$(NULL)


EXTRA_DIST = $(libtagletheadline_la_VALASOURCES)  libtagletheadline.vala.stamp 


MAINTAINERCLEANFILES =                           \
	$(libtagletheadline_la_VALASOURCES:.vala=.c) \
	$(NULL)

