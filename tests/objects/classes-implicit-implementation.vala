interface IFoo : Object {
	public abstract int foo ();
}

interface IBar : Object {
}

class Bar : Object {
	public int foo () {
		assert_not_reached ();
		return -1;
	}
}

class Baz : Object {
	public int foo () {
		return 23;
	}
}

class Foo : Bar, IFoo {
	public int foo () {
		return 42;
	}
}

class Faz : Baz, IFoo, IBar {
}

void main () {
	var foo = new Foo ();
	assert (foo.foo () == 42);

	var baz = new Baz ();
	assert (baz.foo () == 23);
}
