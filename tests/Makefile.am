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
	basic-types/integers.test \
	basic-types/floats.test \
	basic-types/strings.test \
	basic-types/arrays.test \
	basic-types/pointers.test \
	namespaces.test \
	methods/lambda.test \
	control-flow/break.test \
	control-flow/expressions-conditional.test \
	control-flow/for.test \
	control-flow/foreach.test \
	control-flow/switch.test \
	control-flow/sideeffects.test \
	enums/enums.test \
	structs/structs.test \
	structs/gvalue.test \
	delegates/delegates.test \
	objects/classes.test \
	objects/fields.test \
	objects/interfaces.test \
	objects/methods.test \
	objects/properties.test \
	objects/signals.test \
	objects/test-025.test \
	objects/test-026.test \
	objects/test-029.test \
	objects/test-034.test \
	errors/errors.test \
	dbus/basic-types.test \
	dbus/arrays.test \
	$(NULL)

EXTRA_DIST = \
	testrunner.sh \
	$(TESTS) \
	$(NULL)

