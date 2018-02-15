struct Foo {
	int bar;
	uint8[] data;
	int baz;
}

struct Bar {
	int bar;
	uint8[,] data;
	int baz;
}

struct Manam {
	unowned string data[2];
	int idata[2];
	int bar;
}

const Manam[] MANAM = {
	{ { "foo", "bar" }, { 4711, 23 }, 42 },
};

void main () {
	Foo foo = { 23, { 0, 1, 2, 3 }, 42 };
	assert (foo.bar == 23);
	assert (foo.baz == 42);
	assert (foo.data.length == 4);
	assert (foo.data[3] == 3);

	Bar bar = { 23, { { 1, 2 }, { 3, 4 }, { 5, 6 } }, 42 };
	assert (bar.bar == 23);
	assert (bar.baz == 42);
	assert (bar.data.length[0] == 3);
	assert (bar.data.length[1] == 2);
	assert (bar.data[2,0] == 5);

	(unowned string)[] sa = { "foo", "bar" };
	Manam manam = { sa, { 4711, 23 }, 42 };
	assert (manam.data.length == 2);
	assert (manam.data[1] == "bar");
	assert (manam.idata.length == 2);
	assert (manam.idata[1] == 23);
	assert (manam.bar == 42);

	assert (MANAM[0].data.length == 2);
	assert (MANAM[0].data[1] == "bar");
	assert (MANAM[0].idata.length == 2);
	assert (MANAM[0].idata[1] == 23);
	assert (MANAM[0].bar == 42);
}
