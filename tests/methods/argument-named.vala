class Foo {
	public void bar (...) {
		var va = va_list ();
		assert (va.arg<string> () == "foo");
		assert (va.arg<string> () == "FOO");
		assert (va.arg<string> () == "manam");
		assert (va.arg<int> () == 4711);
	}
}

void foo (int first, ...) {
	var va = va_list ();
	assert (va.arg<string> () == "bar");
	assert (va.arg<string> () == "BAR");
	assert (va.arg<string> () == "manam");
	assert (va.arg<int> () == 42);
}

void main () {
	foo (23, bar: "BAR", manam: 42);
	new Foo ().bar (foo: "FOO", manam: 4711);
}
