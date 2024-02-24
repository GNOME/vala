interface IFoo : Object {
	[NoWrapper]
	public abstract int bar ();
}

class Foo : Object, IFoo {
	int bar () {
		return 42;
	}
}

class Bar : Object, IFoo {
	int bar () {
		return 23;
	}

	public Bar () {
		var foo = new Foo ();
		assert (foo.bar () == 42);
	}
}

void main () {
	var foo = new Foo ();
	assert (foo.bar () == 42);
	var bar = new Bar ();
}
