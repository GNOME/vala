struct Foo {
	public int i;
}

void main () {
	var foo = new Foo?[] { { 23 },  { 42 },  { 4711 } };
	{
		Foo f = foo[0];
		assert (f.i == 23);
		assert (foo[0].i == 23);
	}
	{
		Foo f = (Foo) foo[1];
		assert (f.i == 42);
		assert (foo[1].i == 42);
	}
	{
		Foo f = (!) foo[2];
		assert (f.i == 4711);
		assert (foo[2].i == 4711);
	}
}
