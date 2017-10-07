include $(top_srcdir)/Makefile.common

NULL =

AM_CPPFLAGS = \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/vala \
	$(GLIB_CFLAGS) \
	$(GIO_CFLAGS) \
	$(GMODULE_CFLAGS) \
	$(LIBXML_CFLAGS) \
	$(NULL)

BUILT_SOURCES = valadate.vala.stamp

lib_LTLIBRARIES = \
	libvaladate.la \
	$(NULL)

libvaladate_la_VALASOURCES = \
	assembly.vala \
	assemblyerror.vala \
	gnutestreportprinter.vala \
	taptestreportprinter.vala \
	testreportprinter.vala \
	test.vala \
	testadapter.vala \
	testassembly.vala \
	testcase.vala \
	testconfig.vala \
	testmodule.vala \
	testplan.vala \
	testresult.vala \
	testreport.vala \
	testrunner.vala \
	teststatus.vala \
	testsuite.vala \
	xmlfile.vala \
	xmltestreportprinter.vala \
	$(NULL)

libvaladate_la_SOURCES = \
	valadate.vala.stamp \
	$(libvaladate_la_VALASOURCES:.vala=.c) \
	$(NULL)

valadate.vapi valadate.h: valadate.vala.stamp
valadate.vala.stamp: $(libvaladate_la_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		--use-header \
		-H valadate.h \
		--library valadate \
		--vapidir $(top_srcdir)/gee --pkg gee \
		--vapidir $(top_srcdir)/vala --pkg vala \
		--vapidir $(top_srcdir)/vapi --pkg gobject-2.0 \
		--pkg gio-2.0 \
		--pkg gmodule-2.0 \
		--pkg libxml-2.0 \
		--pkg config \
		$^
	@touch $@

libvaladate_la_LDFLAGS = -no-undefined

libvaladate_la_LIBADD = \
	$(top_builddir)/vala/libvala@PACKAGE_SUFFIX@.la \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(GIO_LIBS) \
	$(GMODULE_LIBS) \
	$(LIBXML_LIBS) \
	$(NULL)

EXTRA_DIST = \
	$(libvaladate_la_VALASOURCES) \
	valadate.vapi \
	valadate.deps.in \
	valadate.vala.stamp

MAINTAINERCLEANFILES = \
	valadate.vapi \
	valadate.deps \
	valadate.h \
	$(libvaladate_la_SOURCES:.vala=.c) \
	$(NULL)
