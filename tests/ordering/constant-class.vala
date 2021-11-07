class FooClass {
	public int field = FOO;
	public int array[FOO];
	int pfield = FOO;
	int parray[FOO];

	public FooClass () {
		assert (pfield == 42);
		assert (parray.length == 42);
	}
}

const int FOO = 42;

void main () {
	var foo = new FooClass ();
	assert (foo.field == 42);
	assert (foo.array.length == 42);
}
