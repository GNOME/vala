struct Foo {
	public int i;
}

Foo? foo;

Foo? foo_heap_owned () {
	foo = { 23 };
	return foo;
}

void test_without_destroy () {
	{
		Foo f = foo_heap_owned ();
		assert (f.i == 23);
	}
	{
		Foo f = (Foo) foo_heap_owned ();
		assert (f.i == 23);
	}
	{
		Foo f = (!) foo_heap_owned ();
		assert (f.i == 23);
	}
}

struct Bar {
	public string s;
}

Bar? bar;

Bar? bar_heap_owned () {
	bar = { "bar" };
	return bar;
}

void test_with_destroy () {
	{
		Bar b = bar_heap_owned ();
		assert (b.s == "bar");
	}
	{
		Bar b = (Bar) bar_heap_owned ();
		assert (b.s == "bar");
	}
	{
		Bar b = (!) bar_heap_owned ();
		assert (b.s == "bar");
	}
}

void main () {
	test_without_destroy ();
	test_with_destroy ();
}
