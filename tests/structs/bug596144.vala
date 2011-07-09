struct Foo {
	Object o;
}

void main () {
	var o = new Object ();
	var foo = Foo () { o=o };
	var bar = (owned) foo;
	assert (foo.o == null);
	assert (bar.o == o);
}
