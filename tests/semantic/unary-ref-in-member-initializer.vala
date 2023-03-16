struct Foo {
	void* bar;
}

void main () {
	int bar = 42;

	Foo foo = { ref bar };
	assert (foo.bar == &bar);

	Foo[] foos = {
		{ ref bar }
	};
	assert (foos[0].bar == &bar);
}
