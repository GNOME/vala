struct Foo {
	public int i;
}

const Foo FOO = { 23 };
const Foo FAZ = { 42 };

class Bar {
	public unowned Foo? foo;

	public Bar (Foo _foo) {
		foo = _foo;
	}
}

void main () {
	Bar bar;
	{
		bar = new Bar (FOO);
	}
	assert (bar.foo.i == 23);
	{
		bar.foo = FAZ;
	}
	assert (bar.foo.i == 42);
}
