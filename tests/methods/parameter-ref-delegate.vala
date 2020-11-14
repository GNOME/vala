delegate int FooFunc ();

void foo (int i, ref FooFunc func) {
	assert (func () == i);
	func = () => 4711;
}

int bar () {
	return 23;
}

void main () {
	{
		FooFunc func = bar;
		assert (func () == 23);
		foo (23, ref func);
		assert (func () == 4711);
	}
	{
		int i = 42;
		FooFunc func = () => i;
		assert (func () == 42);
		foo (42, ref func);
		assert (func () == 4711);
	}
}
