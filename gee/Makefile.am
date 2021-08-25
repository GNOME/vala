include $(top_srcdir)/Makefile.common
include Makefile.sources

NULL =

AM_CPPFLAGS = \
	-DG_LOG_DOMAIN=\"vala\" \
	$(COVERAGE_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = gee.vala.stamp

noinst_LTLIBRARIES = \
	libgee.la \
	$(NULL)

libgee_la_SOURCES = \
	gee.vala.stamp \
	$(libgee_la_VALASOURCES:.vala=.c) \
	$(NULL)

geeincludedir = $(includedir)/vala@PACKAGE_SUFFIX@

gee.vapi gee.vala.stamp: $(libgee_la_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		--vapidir $(top_srcdir)/vapi --pkg gobject-2.0 \
		-H valagee.h \
		--library gee \
		$^
	@touch $@

libgee_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(NULL)

EXTRA_DIST = $(libgee_la_VALASOURCES) gee.vapi gee.vala.stamp valagee.h

MAINTAINERCLEANFILES = \
	gee.vapi \
	valagee.h \
	$(libgee_la_VALASOURCES:.vala=.c) \
	$(NULL)
