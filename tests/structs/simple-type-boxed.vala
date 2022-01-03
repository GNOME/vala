[SimpleType]
struct Foo {
	public int i;
	public uint j;
}

void main () {
	Foo? foo = { 42, 4711U };
	assert (foo.i == 42);
	assert (foo.j == 4711U);
}
