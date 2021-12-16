enum Foo {
	MANAM = 23,
	MINIM = 42
}

const Foo FOO = Foo.MANAM;
const Foo FAZ = Foo.MINIM;

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
	assert (bar.foo == 23);
	{
		bar.foo = FAZ;
	}
	assert (bar.foo == 42);
}
