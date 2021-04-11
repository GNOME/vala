struct Foo {
	public int i;
}

Foo?[] foo_array;

Foo?[] foo_array_owned () {
	return new Foo?[] { { 23 },  { 42 },  { 4711 } };
}

unowned Foo?[] foo_array_unowned () {
	foo_array = new Foo?[] { { 23 },  { 42 },  { 4711 } };
	return foo_array;
}

void test_without_destroy () {
	{
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
	{
		Foo f = foo_array_owned ()[0];
		assert (f.i == 23);
	}
	{
		Foo f = (Foo) foo_array_owned ()[1];
		assert (f.i == 42);
	}
	{
		Foo f = (!) foo_array_owned ()[2];
		assert (f.i == 4711);
	}
	{
		Foo f = foo_array_unowned ()[0];
		assert (f.i == 23);
	}
	{
		Foo f = (Foo) foo_array_unowned ()[1];
		assert (f.i == 42);
	}
	{
		Foo f = (!) foo_array_unowned ()[2];
		assert (f.i == 4711);
	}
}

struct Bar {
	public string s;
}

Bar?[] bar_array;

Bar?[] bar_array_owned () {
	return new Bar?[] { { "foo" },  { "bar" },  { "manam" } };
}

unowned Bar?[] bar_array_unowned () {
	bar_array = new Bar?[] { { "foo" },  { "bar" },  { "manam" } };
	return bar_array;
}

void test_with_destroy () {
	{
		var bar = new Bar?[] { { "foo" },  { "bar" },  { "manam" } };
		{
			Bar b = bar[0];
			assert (b.s == "foo");
			assert (bar[0].s == "foo");
		}
		{
			Bar b = (Bar) bar[1];
			assert (b.s == "bar");
			assert (bar[1].s == "bar");
		}
		{
			Bar b = (!) bar[2];
			assert (b.s == "manam");
			assert (bar[2].s == "manam");
		}
	}
	{
		Bar b = bar_array_owned ()[0];
		assert (b.s == "foo");
	}
	{
		Bar b = (Bar) bar_array_owned ()[1];
		assert (b.s == "bar");
	}
	{
		Bar b = (!) bar_array_owned ()[2];
		assert (b.s == "manam");
	}
	{
		Bar b = bar_array_unowned ()[0];
		assert (b.s == "foo");
	}
	{
		Bar b = (Bar) bar_array_unowned ()[1];
		assert (b.s == "bar");
	}
	{
		Bar b = (!) bar_array_unowned ()[2];
		assert (b.s == "manam");
	}
}

void main () {
	test_without_destroy ();
	test_with_destroy ();
}
