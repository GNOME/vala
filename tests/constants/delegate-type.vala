[CCode (has_target = false)]
delegate unowned string FooFunc ();

const FooFunc FOO = func;

unowned string func () {
	return "foo";
}

void main () {
	const FooFunc foo = func;
	assert (foo () == "foo");
	assert (FOO () == "foo");
}
