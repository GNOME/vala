NULL =

BUILT_SOURCES = \
	$(NULL)
noinst_PROGRAMS = \
	$(NULL)

TEST_EXTENSIONS = .vala

TEST_RUNNER = $(abs_top_srcdir)/build-aux/testrunner.sh
VALA_LOG_COMPILER = $(TEST_RUNNER)
GS_LOG_COMPILER = $(TEST_RUNNER)
TEST_LOG_COMPILER = $(TEST_RUNNER)

AM_TESTS_ENVIRONMENT = \
	export EXEEXT=$(EXEEXT); \
	export CFLAGS='$(CFLAGS)'; \
	export CPPFLAGS='$(CPPFLAGS)'; \
	export LDFLAGS='$(LDFLAGS)'; \
	export TEST_CFLAGS='$(TEST_CFLAGS)'; \
	export abs_top_srcdir='$(abs_top_srcdir)'; \
	export abs_top_builddir='$(abs_top_builddir)'; \
	export abs_srcdir='$(abs_srcdir)'; \
	export abs_builddir='$(abs_builddir)'; \
	export CC='$(CC)';

TESTS = $(NULL)

if HAVE_GSTREAMER
TESTS += \
	gstreamer-1.0/gvalue.vala \
	$(NULL)
endif

EXTRA_DIST = \
	gstreamer-1.0/tests-extra-environment.sh \
	$(TESTS) \
	$(NULL)
