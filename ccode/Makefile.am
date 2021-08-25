include $(top_srcdir)/Makefile.common
include Makefile.sources

NULL =

AM_CPPFLAGS = \
	-DG_LOG_DOMAIN=\"vala-ccode\" \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/vala \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = ccode.vala.stamp

noinst_LTLIBRARIES = \
	libvalaccode.la \
	$(NULL)

libvalaccode_la_SOURCES = \
	ccode.vala.stamp \
	$(libvalaccode_la_VALASOURCES:.vala=.c) \
	$(NULL)

ccode.vapi ccode.vala.stamp: $(libvalaccode_la_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		--vapidir $(top_srcdir)/vapi --pkg gobject-2.0 \
		--vapidir $(top_srcdir)/gee --pkg gee \
		--vapidir $(top_srcdir)/vala --pkg vala \
		--pkg config \
		-H valaccode.h \
		--library ccode \
		$^
	touch $@

libvalaccode_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(top_builddir)/vala/libvala@PACKAGE_SUFFIX@.la \
	$(NULL)

EXTRA_DIST = $(libvalaccode_la_VALASOURCES) ccode.vapi ccode.vala.stamp valaccode.h

MAINTAINERCLEANFILES = \
	ccode.vapi \
	valaccode.h \
	$(libvalaccode_la_VALASOURCES:.vala=.c) \
	$(NULL)
