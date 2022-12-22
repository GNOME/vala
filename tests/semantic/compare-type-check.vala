class Foo {
}

void main () {
	var foo = new Foo ();
	var bar = new Foo ();
	assert (foo is Foo == bar is Foo);
}
