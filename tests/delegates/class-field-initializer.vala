delegate string FooFunc ();

FooFunc get_func () {
	var s = "foo";
	return () => { return s; };
}

class Foo {
	public FooFunc func = get_func ();
}

[Compact]
class Bar {
	public FooFunc func = get_func ();
}

void main () {
	{
		var foo = new Foo ();
		assert (foo.func () == "foo");
	}
	{
		var bar = new Bar ();
		assert (bar.func () == "foo");
	}
}
