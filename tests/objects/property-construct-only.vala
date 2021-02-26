class Foo : GLib.Object {
	public string manam { get; construct; }

	construct {
		manam = "foo";
	}
}

class Bar : Foo {
	construct {
		manam = "bar";
	}
}

class Faz : GLib.Object {
	public string manam { get; construct; }

	public Faz () {
		Object (manam : "faz");
	}
}

class Baz : Faz {
	public Baz () {
		Object (manam : "baz");
	}
}

void main () {
	{
		var foo = new Foo ();
		assert (foo.manam == "foo");
	}
	{
		var bar = new Bar ();
		assert (bar.manam == "bar");
	}
	{
		var faz = new Faz ();
		assert (faz.manam == "faz");
	}
	{
		var baz = new Baz ();
		assert (baz.manam == "baz");
	}
}
