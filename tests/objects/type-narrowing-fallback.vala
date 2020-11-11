interface Foo : Object {
	public abstract int get_foo ();
}

class Bar : Object {
	public int get_bar () {
		return 23;
	}
}

class Manam : Bar, Foo {
	public virtual int get_foo () {
		return 42;
	}
}

void main () {
	Foo foo = new Manam ();
	if (foo is Bar) {
		assert (foo.get_bar () == 23);
		assert (foo.get_foo () == 42);
	} else {
		assert_not_reached ();
	}
}
