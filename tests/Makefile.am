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
	basic-types/bug596637.vala \
	basic-types/bug596785.vala \
	namespaces.vala \
	methods/lambda.vala \
	methods/closures.vala \
	methods/bug595538.vala \
	methods/bug596726.vala \
	control-flow/break.vala \
	control-flow/expressions-conditional.vala \
	control-flow/for.vala \
	control-flow/foreach.vala \
	control-flow/switch.vala \
	control-flow/sideeffects.vala \
	enums/enums.vala \
	structs/structs.vala \
	structs/gvalue.vala \
	structs/bug583603.vala \
	structs/bug595587.vala \
	delegates/delegates.vala \
	delegates/bug595639.vala \
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
	objects/bug593260.vala \
	objects/bug596621.vala \
	objects/bug597155.vala \
	errors/errors.vala \
	errors/bug579101.vala \
	errors/bug596228.vala \
	asynchronous/bug595735.vala \
	asynchronous/bug595755.vala \
	asynchronous/bug596177.vala \
	dbus/basic-types.test \
	dbus/arrays.test \
	dbus/async.test \
	dbus/bug596862.vala \
	$(NULL)

check-TESTS: $(TESTS)
	@EXEEXT=$(EXEEXT) $(srcdir)/testrunner.sh $(TESTS)

EXTRA_DIST = \
	testrunner.sh \
	$(TESTS) \
	$(NULL)

