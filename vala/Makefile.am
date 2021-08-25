include $(top_srcdir)/Makefile.common
include Makefile.sources

NULL =

AM_CPPFLAGS = \
	-DG_LOG_DOMAIN=\"vala\" \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	$(GLIB_CFLAGS) \
	$(GMODULE_CFLAGS) \
	-DPACKAGE_DATADIR=\"$(pkgdatadir)\" \
	$(NULL)

BUILT_SOURCES = vala.vala.stamp $(srcdir)/valaversion.vala

$(srcdir)/valaversion.vala:
	sed -e "s#\@VALA_MAJOR_VERSION\@#$(VALA_MAJOR_VERSION)#g" \
		-e "s#\@VALA_MINOR_VERSION\@#$(VALA_MINOR_VERSION)#g" \
		-e "s#\@VALA_MICRO_VERSION\@#$(VALA_MICRO_VERSION)#g" \
		-e "s#\@API_VERSION\@#$(API_VERSION)#g" \
		-e "s#\@PACKAGE_VERSION\@#$(PACKAGE_VERSION)#g" \
		< $@.in > $@

lib_LTLIBRARIES = \
	libvala@PACKAGE_SUFFIX@.la \
	$(NULL)

libvala@PACKAGE_SUFFIX@_la_SOURCES = \
	vala.vala.stamp \
	$(libvala_la_VALASOURCES:.vala=.c) \
	$(NULL)

valaincludedir = $(includedir)/vala@PACKAGE_SUFFIX@

vala.vapi vala.vala.stamp: $(libvala_la_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		--vapidir $(top_srcdir)/vapi --pkg gmodule-2.0 --pkg gobject-2.0 \
		--vapidir $(top_srcdir)/gee --pkg gee \
		--pkg config \
		-H vala.h \
		--library vala \
		$^
	@touch $@

libvala@PACKAGE_SUFFIX@_la_LDFLAGS = \
	-no-undefined \
	$(NULL)

libvala@PACKAGE_SUFFIX@_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	$(top_builddir)/gee/libgee.la \
	$(NULL)

vapidir = $(datadir)/vala/vapi
dist_vapi_DATA = libvala@PACKAGE_SUFFIX@.vapi

libvala@PACKAGE_SUFFIX@.vapi: $(top_srcdir)/gee/gee.vapi $(top_srcdir)/vala/vala.vapi
	cat $^ > $@

EXTRA_DIST = $(libvala_la_VALASOURCES) vala.vapi vala.vala.stamp vala.h valaversion.vala.in

MAINTAINERCLEANFILES = \
	vala.vapi \
	vala.h \
	$(libvala_la_VALASOURCES:.vala=.c) \
	$(NULL)
