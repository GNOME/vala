struct Foo {
	int a;
	int b;
}

void main () {
	Variant a = Foo() { a=2, b=3 };
	Foo b = (Foo) a;
	assert (b.a == 2);
	assert (b.b == 3);
}
