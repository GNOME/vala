class Foo {
	public int read_only { get; default = 42; }
}

class Bar : Object {
	public int read_only { get; default = 23; }
}

interface IBaz : Object {
	public abstract int read_only { get; }
}

class Baz : Object, IBaz {
	public int read_only { get; default = 4711; }
}

void main () {
	var foo = new Foo ();
	assert (foo.read_only == 42);

	var bar = new Bar ();
	assert (bar.read_only == 23);

	var baz = new Baz ();
	assert (baz.read_only == 4711);
}
