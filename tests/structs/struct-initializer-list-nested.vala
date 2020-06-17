struct Foo {
	int i;
	int j;
}

struct Bar {
	Foo a;
	Foo? b;
}

struct Manam {
	Foo a;
	Bar b;
}

struct Baz {
	Foo f;
}

const Baz BAZ = { { 23, 42 } };

const Baz[] BAZ_A = { { { 23, 42 } }, { { 47, 11 } } };

void main () {
	{
		const Baz LOCAL_BAZ = { { 23, 42 } };
	}
	{
		const Baz[] LOCAL_BAZ_A = { { { 23, 42 } }, { { 47, 11 } } };
	}
	{
		Bar bar = { { 23 , 47 }, { 42, 11 } };
		assert (bar.a.j == 47);
		assert (bar.b.i == 42);
	}
	{
		Bar? bar = { { 23 , 47 }, { 42, 11 } };
		assert (bar.a.i == 23);
		assert (bar.b.j == 11);
	}
	{
		Bar bar = {};
		bar = { { 23 , 47 }, { 42, 11 } };
		assert (bar.a.j == 47);
		assert (bar.b.i == 42);
	}
	{
		Manam manam = { { 23, 42 }, { { 23 , 47 }, { 42, 11 } } };
		assert (manam.a.i == 23);
		assert (manam.b.b.j == 11);
	}
	{
		Manam manam = {};
		manam = { { 23, 42 }, { { 23 , 47 }, { 42, 11 } } };
		assert (manam.a.i == 23);
		assert (manam.b.b.j == 11);
	}
	{
		Manam? manam = { { 23, 42 }, { { 23 , 47 }, { 42, 11 } } };
		assert (manam.a.j == 42);
		assert (manam.b.a.i == 23);
	}
}
