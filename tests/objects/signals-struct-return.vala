struct Foo {
	public string s;
	public int i;
}

class Bar : Object {
	public signal Foo on_foo ();
	public signal Foo on_foo_with_arg (string s);
	public signal Foo? on_bar ();
	public signal Foo? on_bar_with_arg (string s);
}

void main () {
	{
		var bar = new Bar ();
		bar.on_foo.connect (() => {
			return { "foo", 23 };
		});
		bar.on_foo_with_arg.connect ((s) => {
			assert (s == "foo");
			return { "foo", 42 };
		});
		var foo = bar.on_foo ();
		assert (foo.s == "foo");
		assert (foo.i == 23);
		var foo2 = bar.on_foo_with_arg ("foo");
		assert (foo2.s == "foo");
		assert (foo2.i == 42);
	}
	{
		var bar = new Bar ();
		bar.on_bar.connect (() => {
			return { "bar", 42 };
		});
		bar.on_bar_with_arg.connect ((s) => {
			assert (s == "bar");
			return { "bar", 23 };
		});
		var foo = bar.on_bar ();
		assert (foo.s == "bar");
		assert (foo.i == 42);
		var foo2 = bar.on_bar_with_arg ("bar");
		assert (foo2.s == "bar");
		assert (foo2.i == 23);
	}
}
