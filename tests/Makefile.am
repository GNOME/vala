NULL =

INCLUDES = \
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

testenchant_SOURCES = \
	testenchant.stamp \
	testenchant.c \
	testenchant.h \
	testenchant.vala \
	$(NULL)

testenchant.stamp: $(filter %.vala,$(testenchant_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --pkg enchant $^
	touch $@

TESTS_ENVIRONMENT = $(srcdir)/testrunner.sh

TESTS = \
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
	$(NULL)

EXTRA_DIST = \
	testrunner.sh \
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
	test-001.out \
	test-002.out \
	test-003.out \
	test-004.out \
	test-005.out \
	test-006.out \
	test-007.out \
	test-008.out \
	test-009.out \
	test-010.out \
	test-011.out \
	test-012.out \
	test-013.out \
	test-014.out \
	test-015.out \
	test-016.out \
	test-017.out \
	test-018.out \
	test-019.out \
	test-020.out \
	test-021.out \
	test-022.out \
	test-023.out \
	test-024.out \
	test-025.out \
	test-026.out \
	test-027.out \
	test-028.out \
	test-029.out \
	test-030.out \
	test-031.out \
	test-032.out \
	test-033.out \
	test-034.out \
	test-035.out \
	\
	testenchant.stamp \
	testenchant.vala \
	$(NULL)

