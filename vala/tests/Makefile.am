include $(top_srcdir)/Makefile.common

NULL =

AM_CPPFLAGS = \
	-DG_LOG_DOMAIN=\"printer\" \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/vala \
	$(GLIB_CFLAGS) \
	-DPACKAGE_DATADIR=\"$(pkgdatadir)\" \
	$(NULL)

BUILT_SOURCES = printer.vala.stamp

noinst_PROGRAMS = \
	printer \
	$(NULL)

printer_VALASOURCES = \
	testprinter.vala \
	$(NULL)

printer_SOURCES = \
	printer.vala.stamp \
	$(printer_VALASOURCES:.vala=.c) \
	$(NULL)

printer.vala.stamp: $(printer_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		--vapidir $(top_srcdir)/vapi --pkg gobject-2.0 \
		--vapidir $(top_srcdir)/gee --pkg gee \
		--vapidir $(top_srcdir)/vala --pkg vala \
		--pkg config \
		$^
	@touch $@

printer_LDADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(top_builddir)/vala/libvala@PACKAGE_SUFFIX@.la \
	$(NULL)

EXTRA_DIST = $(printer_VALASOURCES) printer.vala.stamp

MAINTAINERCLEANFILES = \
	$(printer_VALASOURCES:.vala=.c) \
	$(NULL)
