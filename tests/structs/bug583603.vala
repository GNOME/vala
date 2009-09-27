struct Foo {
	int bar;
}

void main() {
	int i = 42;
	Foo foo = { i };
	assert (foo.bar == 42);
}
