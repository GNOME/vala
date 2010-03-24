struct Foo {
	int i;
}

void main () {
	var foo = Foo () { i = 42 };
	assert (foo.i == 42);
}
