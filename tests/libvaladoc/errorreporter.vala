
using Valadoc;

void main () {
	var reporter = new ErrorReporter ();
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);

	// simple errors:
	reporter.simple_error ("error 1 %d %s", 1, "foo");
	assert (reporter.warnings == 0);
	assert (reporter.errors == 1);

	reporter.simple_error ("error 2");
	assert (reporter.warnings == 0);
	assert (reporter.errors == 2);


	// simple warnings:
	reporter.simple_warning ("warning 1 %d %s", 1, "foo");
	assert (reporter.warnings == 1);
	assert (reporter.errors == 2);

	reporter.simple_warning ("warning 2");
	assert (reporter.warnings == 2);
	assert (reporter.errors == 2);


	// errors:
	reporter.error ("file", 1, 1, 1, "line", "error, complex, 1 %d %s", 1, "foo");
	assert (reporter.warnings == 2);
	assert (reporter.errors == 3);

	reporter.error ("file", 1, 1, 1, "line", "error, complex, 2");
	assert (reporter.warnings == 2);
	assert (reporter.errors == 4);


	// warnngs:
	reporter.warning ("file", 1, 1, 1, "line", "warning, complex, 1 %d %s", 1, "foo");
	assert (reporter.warnings == 3);
	assert (reporter.errors == 4);

	reporter.warning ("file", 1, 1, 1, "line", "warning, complex, 2");
	assert (reporter.warnings == 4);
	assert (reporter.errors == 4);
}

