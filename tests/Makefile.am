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
	basic-types/bug595751.vala \
	basic-types/bug596637.vala \
	basic-types/bug596785.vala \
	namespaces.vala \
	methods/lambda.vala \
	methods/closures.vala \
	methods/bug595538.vala \
	methods/bug596726.vala \
	methods/bug597426.vala \
	methods/bug598738.vala \
	methods/bug599892.vala \
	methods/bug613483.vala \
	methods/bug620673.vala \
	control-flow/break.vala \
	control-flow/expressions-conditional.vala \
	control-flow/for.vala \
	control-flow/foreach.vala \
	control-flow/switch.vala \
	control-flow/sideeffects.vala \
	enums/enums.vala \
	structs/structs.vala \
	structs/gvalue.vala \
	structs/bug530605.vala \
	structs/bug583603.vala \
	structs/bug595587.vala \
	structs/bug606202.vala \
	structs/bug613513.vala \
	structs/bug613825.vala \
	structs/bug622422.vala \
	delegates/delegates.vala \
	delegates/bug595610.vala \
	delegates/bug595639.vala \
	objects/classes.vala \
	objects/fields.vala \
	objects/interfaces.vala \
	objects/methods.vala \
	objects/properties.vala \
	objects/regex.vala \
	objects/signals.vala \
	objects/test-025.vala \
	objects/test-026.vala \
	objects/test-029.vala \
	objects/test-034.vala \
	objects/bug566909.vala \
	objects/bug593260.vala \
	objects/bug596621.vala \
	objects/bug597155.vala \
	objects/bug597161.vala \
	objects/bug613486.vala \
	objects/bug620706.vala \
	objects/bug624594.vala \
	errors/errors.vala \
	errors/bug567181.vala \
	errors/bug579101.vala \
	errors/bug596228.vala \
	errors/bug623049.vala \
	asynchronous/bug595735.vala \
	asynchronous/bug595755.vala \
	asynchronous/bug596177.vala \
	asynchronous/bug597294.vala \
	asynchronous/bug598677.vala \
	asynchronous/bug598697.vala \
	asynchronous/bug598698.vala \
	asynchronous/bug599568.vala \
	asynchronous/bug600827.vala \
	asynchronous/bug601558.vala \
	asynchronous/bug613484.vala \
	asynchronous/bug620740.vala \
	dbus/basic-types.test \
	dbus/arrays.test \
	dbus/structs.test \
	dbus/async.test \
	dbus/signals.test \
	dbus/bug596862.vala \
	dbus/bug602003.test \
	$(NULL)

check-TESTS: $(TESTS)
	@EXEEXT=$(EXEEXT) $(srcdir)/testrunner.sh $(TESTS)

EXTRA_DIST = \
	testrunner.sh \
	$(TESTS) \
	$(NULL)

