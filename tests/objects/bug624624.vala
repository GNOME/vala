class Foo : Object {
	public static bool destroyed;
	public signal void sig ();

	~Foo () {
		destroyed = true;
	}
}

class Bar : Object {
	public static bool destroyed;
	Foo foo;

	public Bar (Foo f) {
		foo = f;
		foo.sig.connect (() => assert_not_reached ());
	}

	~Bar () {
		destroyed = true;
	}
}

class Manam : Object {
	public static bool destroyed;
	public static bool reached;
	Foo foo;

	public Manam (Foo f) {
		foo = f;
		foo.sig.connect (() => reached = true);
	}

	~Manam () {
		destroyed = true;
	}
}

void bar (Foo f) {
	{
		var bar = new Bar (f);
		// bar should be finalized here
	}
	assert (Bar.destroyed);
}

void main () {
	{
		var foo = new Foo ();
		bar (foo);
		var manam = new Manam (foo);
		foo.sig ();
		assert (Manam.reached);
		// manam and then foo should be finalized here
	}
	assert (Manam.destroyed);
	assert (Foo.destroyed);
}
