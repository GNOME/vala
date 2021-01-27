[SimpleType]
struct Foo {
	public int i;
	public uint j;

	public Foo () {
		i = 42;
		j = 4711U;
	}
}

void main () {
	var foo = Foo ();
	assert (foo.i == 42);
	assert (foo.j == 4711U);
}
