include $(top_srcdir)/Makefile.common

NULL =

TESTS_ENVIRONMENT = EXEEXT=$(EXEEXT) PACKAGE_SUFFIX=$(PACKAGE_SUFFIX) TOPBUILDDIR=$(abs_top_builddir) TOPSRCDIR=$(abs_top_srcdir) $(srcdir)/testrunner.sh

TESTS = \
	libvaladoc/errorreporter.vala \
	libvaladoc/markupreader.vala \
	libvaladoc/gtkdoc-scanner.vala \
	libvaladoc/parser/manyrule.vala \
	libvaladoc/parser/oneofrule.vala \
	libvaladoc/parser/sequencerule.vala \
	libvaladoc/parser/optionalrule.vala \
	libvaladoc/parser/stubrule.vala \
	$(NULL)

check-TESTS: $(TESTS)
	@EXEEXT=$(EXEEXT) PACKAGE_SUFFIX=$(PACKAGE_SUFFIX) TOPBUILDDIR=$(abs_top_builddir) TOPSRCDIR=$(abs_top_srcdir) $(srcdir)/testrunner.sh $(TESTS)
	G_DEBUG=fatal_warnings $(builddir)/driver

AM_CFLAGS = \
	-DPACKAGE_DATADIR=\"$(libdir)/valadoc\" \
	-DPACKAGE_VERSION=\"$(VERSION)\" \
	-DTOP_SRC_DIR=\"$(abs_top_srcdir)\" \
	-I$(top_srcdir)/libvaladoc/ \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/ccode \
	-I$(top_srcdir)/vala \
	-I$(top_srcdir)/codegen \
	$(COVERAGE_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(GMODULE_CFLAGS) \
	$(LIBGVC_CFLAGS) \
	$(NULL)

BUILT_SOURCES = driver.vala.stamp

check_PROGRAMS = driver

driver_VALASOURCES = \
	drivers/driver-test.vala \
	drivers/generic-api-test.vala \
	$(top_srcdir)/valadoc/driver.vala \
	$(top_srcdir)/valadoc/girwriter.vala \
	$(top_srcdir)/valadoc/initializerbuilder.vala \
	$(top_srcdir)/valadoc/symbolresolver.vala \
	$(top_srcdir)/valadoc/treebuilder.vala \
    $(NULL)

driver_SOURCES = \
	driver.vala.stamp \
	drivers/driver-test.c \
	drivers/generic-api-test.c \
	driver.c \
	girwriter.c \
	initializerbuilder.c \
	symbolresolver.c \
	treebuilder.c \
	$(NULL)

driver_LDADD = \
	$(top_builddir)/libvaladoc/libvaladoc@PACKAGE_SUFFIX@.la \
	$(top_builddir)/vala/libvala@PACKAGE_SUFFIX@.la \
	$(top_builddir)/ccode/libvalaccode.la \
	$(top_builddir)/codegen/libvalaccodegen.la \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	$(LIBGVC_LIBS) \
	$(NULL)

driver.vala.stamp: $(driver_VALASOURCES) $(top_srcdir)/vala/libvala@PACKAGE_SUFFIX@.vapi $(top_srcdir)/libvaladoc/valadoc@PACKAGE_SUFFIX@.vapi
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		--vapidir $(top_srcdir)/vapi \
		--pkg gmodule-2.0 \
		--pkg gobject-2.0 \
		--pkg libgvc \
		--vapidir $(top_srcdir)/vala --pkg libvala@PACKAGE_SUFFIX@ \
		--vapidir $(top_srcdir)/ccode --pkg ccode \
		--vapidir $(top_srcdir)/codegen --pkg codegen \
		--vapidir $(top_srcdir)/libvaladoc --pkg valadoc@PACKAGE_SUFFIX@ \
		--pkg config \
		$(filter %.vala %.c,$^)
	touch $@

EXTRA_DIST = \
	driver.vala.stamp \
	$(driver_SOURCES) \
	testrunner.sh \
	drivers/api-test.data.vapi \
	drivers/driver-test.vala \
	drivers/generic-api-test.vala \
	libvaladoc/parser/generic-scanner.vala \
	$(TESTS) \
	$(NULL)

MAINTAINERCLEANFILES = \
	driver.vala.stamp \
	$(driver_SOURCES) \
	$(NULL)
