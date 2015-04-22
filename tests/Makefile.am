NULL =

AM_CPPFLAGS = \
	$(GLIB_CFLAGS) \
	$(NULL)
AM_LDFLAGS = \
	$(GLIB_LIBS) \
	$(NULL)

BUILT_SOURCES = \
	$(NULL)
noinst_PROGRAMS = \
	$(NULL)

TESTS_ENVIRONMENT = EXEEXT=$(EXEEXT) TOPBUILDDIR=$(abs_top_builddir) TOPSRCDIR=$(abs_top_srcdir) $(srcdir)/testrunner.sh

TESTS = \
	libvaladoc/errorreporter.vala \
	libvaladoc/markupreader.vala \
	libvaladoc/gtkdoc-scanner.vala \
	libvaladoc/parser/manyrule.vala \
	libvaladoc/parser/oneofrule.vala \
	libvaladoc/parser/sequencerule.vala \
	libvaladoc/parser/optionalrule.vala \
	libvaladoc/parser/stubrule.vala \
	drivers/driver-0-16.vala \
	drivers/driver-0-18.vala \
	drivers/driver-0-20.vala \
	drivers/driver-0-22.vala \
	drivers/driver-0-24.vala \
	drivers/driver-0-26.vala \
	drivers/driver-0-28.vala \
	drivers/driver-0-30.vala \
	$(NULL)

check-TESTS: $(TESTS)
	@EXEEXT=$(EXEEXT) TOPBUILDDIR=$(abs_top_builddir) TOPSRCDIR=$(abs_top_srcdir) $(srcdir)/testrunner.sh $(TESTS)

EXTRA_DIST = \
	testrunner.sh \
	drivers/api-test.data.vapi \
	drivers/generic-api-test.vala \
	libvaladoc/parser/generic-scanner.vala \
	$(TESTS) \
	$(NULL)

