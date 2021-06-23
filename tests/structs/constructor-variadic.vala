struct Foo {
	public string s;

	public Foo (string first_arg, ...) {
		assert (first_arg == "foo");
		va_list args = va_list ();
		string second_arg = args.arg<string> ();
		assert (second_arg == "bar");
		s = first_arg + second_arg;
	}
}

void main () {
	{
		var foo = Foo ("foo", "bar");
		assert (foo.s == "foobar");
	}
}
