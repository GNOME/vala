class Foo {
	public string s;

	public Foo (string first_arg, ...) {
		assert (first_arg == "foo");
		va_list args = va_list ();
		string second_arg = args.arg<string> ();
		assert (second_arg == "bar");
		s = first_arg + second_arg;
	}
}

[Compact]
class Bar {
	public string s;

	public Bar (string first_arg, ...) {
		assert (first_arg == "bar");
		va_list args = va_list ();
		string second_arg = args.arg<string> ();
		assert (second_arg == "foo");
		s = first_arg + second_arg;
	}
}

void main () {
	{
		var foo = new Foo ("foo", "bar");
		assert (foo.s == "foobar");
	}
	{
		var bar = new Bar ("bar", "foo");
		assert (bar.s == "barfoo");
	}
}
