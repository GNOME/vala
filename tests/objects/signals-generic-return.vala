class Foo<G,T> : Object {
	public signal G on_foo ();
	public signal T on_bar ();
}

int cb_foo () {
	return 23;
}

string cb_bar () {
	return "foo";
}

void main () {
	{
		var foo = new Foo<int,string> ();
		foo.on_foo.connect (() => {
			return 42;
		});
		foo.on_bar.connect (() => {
			return "bar";
		});

		var bar = foo.on_foo ();
		assert (bar == 42);
		var bar2 = foo.on_bar ();
		assert (bar2 == "bar");
	}
	{
		var foo = new Foo<int,string> ();
		foo.on_foo.connect (cb_foo);
		foo.on_bar.connect (cb_bar);

		var bar = foo.on_foo ();
		assert (bar == 23);
		var bar2 = foo.on_bar ();
		assert (bar2 == "foo");
	}
}
