enum Foo {
	BAR = 23;
}

struct Bar {
	public char array[Foo.BAR];
}

void foo (uint array[Foo.BAR]) {
	assert (array.length == 23);
}

void main () {
	int array[Foo.BAR];
	assert (array.length == 23);

	var bar = Bar ();
	assert (bar.array.length == 23);
}
