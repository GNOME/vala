struct Foo {
	int i;
}

struct Bar : Foo {
}

void main () {
	var f1 = Foo () { i = 42 };
	var f2 = Foo () { i = 42 };

	assert (f1 == f2);

	var b1 = Bar () { i = 42 };
	var b2 = Bar () { i = 42 };

	assert (b1 == b2);
}
