class Foo : Object {
	public signal void bar ();
}

Foo do_foo () {
	var foo = new Foo ();
	foo.bar.connect (() => {
		assert (foo is Foo);
	});
	return foo;
}

void main () {
	var foo = do_foo ();
	foo.bar ();
}
