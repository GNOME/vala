struct Bar {
	public string s;
	public int i;
}

struct Baz : Bar {
}

class Foo : Object {
	public Bar foo { get; set; }
	public Bar bar { owned get; owned set; }
	public Baz faz { get; set; }
	public Baz baz { owned get; owned set; }
}

void main () {
	var foo = new Foo ();
	foo.bar = { "bar", 23 };
	assert (foo.bar.s == "bar");
	assert (foo.bar.i == 23);
	foo.foo = { "foo", 42 };
	assert (foo.foo.s == "foo");
	assert (foo.foo.i == 42);
	foo.baz = { "baz", 4711 };
	assert (foo.baz.s == "baz");
	assert (foo.baz.i == 4711);
	foo.faz = { "faz", 72 };
	assert (foo.faz.s == "faz");
	assert (foo.faz.i == 72);
}
