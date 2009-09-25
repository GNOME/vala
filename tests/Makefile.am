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

TESTS_ENVIRONMENT = EXEEXT=$(EXEEXT) $(srcdir)/testrunner.sh

TESTS = \
	basic-types/integers.vala \
	basic-types/floats.vala \
	basic-types/strings.vala \
	basic-types/arrays.vala \
	basic-types/pointers.vala \
	namespaces.vala \
	methods/lambda.vala \
	methods/closures.vala \
	control-flow/break.vala \
	control-flow/expressions-conditional.vala \
	control-flow/for.vala \
	control-flow/foreach.vala \
	control-flow/switch.vala \
	control-flow/sideeffects.vala \
	enums/enums.vala \
	structs/structs.vala \
	structs/gvalue.vala \
	delegates/delegates.vala \
	objects/classes.vala \
	objects/fields.vala \
	objects/interfaces.vala \
	objects/methods.vala \
	objects/properties.vala \
	objects/signals.vala \
	objects/test-025.vala \
	objects/test-026.vala \
	objects/test-029.vala \
	objects/test-034.vala \
	errors/errors.vala \
	dbus/basic-types.test \
	dbus/arrays.test \
	dbus/async.test \
	$(NULL)

check-TESTS: $(TESTS)
	@EXEEXT=$(EXEEXT) $(srcdir)/testrunner.sh $(TESTS)

EXTRA_DIST = \
	testrunner.sh \
	$(TESTS) \
	$(NULL)

