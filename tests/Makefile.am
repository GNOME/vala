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
	$(NULL)

if HAVE_LIBVALA_0_20_X
TESTS += drivers/driver-0-20.vala
endif

if HAVE_LIBVALA_0_22_X
TESTS += drivers/driver-0-22.vala
endif

if HAVE_LIBVALA_0_24_X
TESTS += drivers/driver-0-24.vala
endif

if HAVE_LIBVALA_0_26_X
TESTS += drivers/driver-0-26.vala
endif

if HAVE_LIBVALA_0_28_X
TESTS += drivers/driver-0-28.vala
endif

if HAVE_LIBVALA_0_30_X
TESTS += drivers/driver-0-30.vala
endif

if HAVE_LIBVALA_0_32_X
TESTS += drivers/driver-0-32.vala
endif

if HAVE_LIBVALA_0_34_X
TESTS += drivers/driver-0-34.vala
endif

if HAVE_LIBVALA_0_36_X
TESTS += drivers/driver-0-36.vala
endif

check-TESTS: $(TESTS)
	@EXEEXT=$(EXEEXT) TOPBUILDDIR=$(abs_top_builddir) TOPSRCDIR=$(abs_top_srcdir) $(srcdir)/testrunner.sh $(TESTS)

EXTRA_DIST = \
	testrunner.sh \
	drivers/api-test.data.vapi \
	drivers/generic-api-test.vala \
	libvaladoc/parser/generic-scanner.vala \
	$(TESTS) \
	$(NULL)

