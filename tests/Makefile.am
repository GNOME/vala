NULL =

AM_CPPFLAGS = \
	$(GLIB_CFLAGS) \
	$(ENCHANT_CFLAGS) \
	$(NULL)
AM_LDFLAGS = \
	$(GLIB_LIBS) \
	$(ENCHANT_LIBS) \
	$(NULL)

BUILT_SOURCES = \
	$(NULL)
noinst_PROGRAMS = \
	$(NULL)

if HAVE_ENCHANT
BUILT_SOURCES += testenchant.stamp
noinst_PROGRAMS += testenchant
endif

testenchant_VALASOURCES = \
	testenchant.vala \
	$(NULL)

testenchant_SOURCES = \
	testenchant.stamp \
	$(testenchant_VALASOURCES:.vala=.c) \
	$(testenchant_VALASOURCES:.vala=.h) \
	$(NULL)

testenchant.stamp: $(testenchant_VALASOURCES)
	$(VALAC) --vapidir $(srcdir)/../vapi --pkg enchant $^
	touch $@

TESTS_ENVIRONMENT = $(srcdir)/testrunner.sh

TESTS = \
	hello.vala \
	classes.vala \
	structs.vala \
	property-sample.vala \
	\
	test-001.vala \
	test-002.vala \
	test-003.vala \
	test-004.vala \
	test-005.vala \
	test-006.vala \
	test-007.vala \
	test-008.vala \
	test-009.vala \
	test-010.vala \
	test-011.vala \
	test-012.vala \
	test-013.vala \
	test-014.vala \
	test-015.vala \
	test-016.vala \
	test-017.vala \
	test-018.vala \
	test-019.vala \
	test-020.vala \
	test-021.vala \
	test-022.vala \
	test-023.vala \
	test-024.vala \
	test-025.vala \
	test-026.vala \
	test-027.vala \
	test-028.vala \
	test-029.vala \
	test-030.vala \
	test-031.vala \
	test-032.vala \
	test-033.vala \
	test-034.vala \
	test-035.vala \
	test-036.vala \
	test-037.vala \
	$(NULL)

EXTRA_DIST = \
	testrunner.sh \
	$(TESTS) \
	\
	hello.exp \
	classes.exp \
	structs.exp \
	property-sample.exp \
	\
	test-001.exp \
	test-002.exp \
	test-003.exp \
	test-004.exp \
	test-005.exp \
	test-006.exp \
	test-007.exp \
	test-008.exp \
	test-009.exp \
	test-010.exp \
	test-011.exp \
	test-012.exp \
	test-013.exp \
	test-014.exp \
	test-015.exp \
	test-016.exp \
	test-017.exp \
	test-018.exp \
	test-019.exp \
	test-020.exp \
	test-021.exp \
	test-022.exp \
	test-023.exp \
	test-024.exp \
	test-025.exp \
	test-026.exp \
	test-027.exp \
	test-028.exp \
	test-029.exp \
	test-030.exp \
	test-031.exp \
	test-032.exp \
	test-033.exp \
	test-034.exp \
	test-035.exp \
	test-036.exp \
	test-037.exp \
	\
	testenchant.stamp \
	testenchant.vala \
	$(NULL)

