include $(top_srcdir)/Makefile.common

NULL =

AM_CPPFLAGS = \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/ccode \
	-I$(top_srcdir)/vala \
	-I$(top_srcdir)/codegen \
	$(GLIB_CFLAGS) \
	$(GIO_CFLAGS) \
	$(GMODULE_CFLAGS) \
	$(LIBXML_CFLAGS) \
	-g \
	$(NULL)

BUILT_SOURCES = valadate.vala.stamp valadate.deps

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

valadate.vapi valadate.vala.stamp: $(libvaladate_la_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		-g \
		--vapidir $(top_srcdir)/vapi --pkg gobject-2.0 \
		--pkg gio-2.0 \
		--pkg gmodule-2.0 \
		--pkg libxml-2.0 \
		--pkg config \
		--pkg libvala@PACKAGE_SUFFIX@ \
		-H valadate.h \
		--library valadate \
		$^
	@touch $@

valadate.deps : valadate.deps.in
	$(SED) -e 's,[@]PACKAGE_SUFFIX[@],$(PACKAGE_SUFFIX),g' < valadate.deps.in > valadate.deps

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
