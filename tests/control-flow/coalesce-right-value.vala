struct Foo {
	public int i;
}

void main () {
	{
		int? null_int = null;
		int i = null_int ?? 42;
		assert (i == 42);
	}
	{
		Foo? null_foo = null;
		Foo right_foo = { 42 };
		Foo foo = null_foo ?? right_foo;
		assert (foo.i == 42);
	}
}
