class Foo {
	public int i;
}

void main () {
	Foo? foo = new Foo ();
	if (foo is Foo) {
		foo.i = 42;
		assert (foo.i == 42);
	} else {
		assert_not_reached ();
	}
}
