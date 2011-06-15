class Foo {
	public Foo foo;
}

void main () {
	var foo = new Foo ();
	foo.foo = (owned) foo;
}
