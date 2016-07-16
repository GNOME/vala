include $(top_srcdir)/Makefile.common


lib_LTLIBRARIES = \
	libvaladate.la
	$(NULL)

libvaladate_la_SOURCES = \
	assembly.vala \
	compositetest.vala \
	module.vala \
	tap.vala \
	tapresult.vala \
	test.vala \
	testcase.vala \
	testconfig.vala \
	testexplorer.vala \
	testfixture.vala \
	testresult.vala \
	testresultfactory.vala \
	testrunner.vala \
	testsuite.vala \
	$(NULL)

libvaladate_la_VALAFLAGS = \
	--vapidir $(top_srcdir)/vapi \
	--vapidir $(top_srcdir)/gee \
	--vapidir $(top_srcdir)/vala \
	--pkg gio-2.0 \
	--pkg gmodule-2.0 \
	--pkg vala \
	--pkg gee \
	--pkg config \
	--library valadate \
	--vapi valadate.vapi \
	-H valadate.h \
	-g \
	$(NULL)


libvaladate_la_CFLAGS = \
	$(GLIB_CFLAGS) \
	$(GMODULE_CFLAGS) \
	-I$(top_srcdir)/vala \
	$(NULL)

libvaladate_la_CPPFLAGS = \
	$(GLIB_CPPFLAGS) \
	$(GMODULE_CPPFLAGS) \
	-I$(top_srcdir)/vala \
	-I$(top_srcdir)/gee \
	$(NULL)


libvaladate_la_LDFLAGS = \
	-export-dynamic \
	-shared \
	$(NULL)

libvaladate_la_LIBADD = \
	$(top_builddir)/vala/libvalacore.la \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	$(NULL)

libvaladateincludedir = $(includedir)/vala@PACKAGE_SUFFIX@

libvaladateinclude_HEADERS = \
	valadate.h \
	$(NULL)

EXTRA_DIST = $(libvaladate_la_VALASOURCES) valadate.vapi valadate.vala.stamp

CLEANFILES = \
	$(libvaladate_la_SOURCES:.vala=.c) \
	valadate.vapi \
	valadate.h \
	$(NULL)
	

MAINTAINERCLEANFILES = \
	valadate.vapi \
	valadate.h \
	$(libvaladate_la_SOURCES:.vala=.c) \
	$(NULL)
