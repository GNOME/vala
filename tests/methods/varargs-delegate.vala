delegate string Foo ();

string foo (void* data) {
	return "foo";
}

void bar (int first, ...) {
	assert (first == 23);
	var args = va_list ();
	Foo** out_func = args.arg ();
	*out_func = (Foo*) foo;
}

void baz (int first, ...) {
	assert (first == 42);
	var args = va_list ();
	Foo func = args.arg ();
	assert (func () == "foo");
}

void main () {
	{
		Foo func;
		bar (23, out func);
		assert (func () == "foo");
	}
	{
		baz (42, foo);
	}
}
