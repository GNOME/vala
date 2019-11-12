class Foo : Object {
	public string foo { get; set; }
}

class Bar : Object {
	public int bar { get; set; }
}

bool to_int (Binding b, Value from, ref Value to) {
	to.set_int (from.get_string ().to_int ());
	return true;
}

bool to_string (Binding b, Value from, ref Value to) {
	to.set_string (from.get_int ().to_string ());
	return true;
}

void main () {
	var foo = new Foo ();
	var bar = new Bar ();

	foo.bind_property ("foo", bar, "bar", BindingFlags.BIDIRECTIONAL,
		(BindingTransformFunc) to_int, (BindingTransformFunc) to_string);

	foo.foo = "42";
	assert (bar.bar == 42);
	bar.bar = 23;
	assert (foo.foo == "23");
}
